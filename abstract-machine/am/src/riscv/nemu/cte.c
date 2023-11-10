#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>


static Context* (*user_handler)(Event, Context*) = NULL;

Context* __am_irq_handle(Context *c) {  //根据系统调用号，得到事件原因

  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) { //例如中断，不需要+4
      case 11 : ev.event = EVENT_SYSCALL ; c->mepc += 4;   //对于ecall触发的异常，由软件实现mepc+4  syscall需要+4
                break;
      default: ev.event = EVENT_ERROR; break;
    }

    #ifdef CONFIG_ETRACE
      printf("irq happen, event is %d\n", ev.event);
    #endif
    
    c = user_handler(ev, c);
    assert(c != NULL);
  }
  return c;
}

extern void __am_asm_trap(void);

bool cte_init(Context*(*handler)(Event, Context*)) {
  // initialize exception entry
  asm volatile("csrw mtvec, %0" : : "r"(__am_asm_trap));

  // initialize for difftest
  // asm volatile("csrw mstatus, %0" : : "i"(0xa00001800)); 立即数域没有这么大
  unsigned long int temp = 0xa00001800;
  asm volatile("csrw mstatus, %0" : : "r"(temp));

  
  // register event handler
  user_handler = handler;

  return true;
}

Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  Context *context_k = (Context *)((uint64_t)kstack.end - sizeof(Context));

  memset(context_k, 0, sizeof(Context));

  context_k->mstatus = (uintptr_t)0xa00001800;  //配合difftest spike
  context_k->mepc = (uintptr_t)entry;
  return context_k;
}

void yield() {
  // asm volatile("li a7, -1; ecall");
  asm volatile("li a7, 1");   //yield系统调用号设置为1
  asm volatile("ecall");
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}
