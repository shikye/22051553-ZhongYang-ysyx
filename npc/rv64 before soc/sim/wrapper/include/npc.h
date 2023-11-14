#ifndef NPC_RISCV64_H__
#define NPC_RISCV64_H__

#define DEVICE_BASE 0xa0000000

#define MMIO_BASE 0xa0000000



#define SERIAL_PORT     (DEVICE_BASE + 0x00003f8)
#define KBD_ADDR        (DEVICE_BASE + 0x0000060)
#define RTC_ADDRH        (DEVICE_BASE + 0x000004C)
#define RTC_ADDRL        (DEVICE_BASE + 0x0000048)
#define RTC_BASE        (DEVICE_BASE + 0x0000048)
#define VGACTL_ADDR     (DEVICE_BASE + 0x0000100)
#define AUDIO_ADDR      (DEVICE_BASE + 0x0000200)
#define DISK_ADDR       (DEVICE_BASE + 0x0000300)
#define FB_ADDR         (MMIO_BASE   + 0x1000000)
#define AUDIO_SBUF_ADDR (MMIO_BASE   + 0x1200000)

#define SYNC_ADDR (VGACTL_ADDR + 4)

#endif