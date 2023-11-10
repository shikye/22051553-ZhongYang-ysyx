package rv64
import chisel3._
import chisel3.util._
import Define._

class CSRDeIO extends Bundle{
    val csr_raddr = Input(UInt(CSR_ADDR_LEN.W))
    val csr_rdata = Output(UInt(X_LEN.W))
}

class CSRWbIO extends Bundle{
    val rd = Input(UInt(CSR_ADDR_LEN.W))
    val csr_wen = Input(Bool())
    val csr_wdata = Input(UInt(X_LEN.W))
}

class CSRTrapIO extends Bundle{
    val MTVEC = Output(UInt(X_LEN.W))
    val MCAUSE = Output(UInt(X_LEN.W))
    val MEPC = Output(UInt(X_LEN.W))
    val MIE = Output(UInt(X_LEN.W))
    val MIP = Output(UInt(X_LEN.W))
    val MSTATUS = Output(UInt(X_LEN.W))

    val rd = Input(UInt(CSR_ADDR_LEN.W))
    val csr_wen = Input(Bool())
    val csr_wdata = Input(UInt(X_LEN.W))
}

class CSRIO extends Bundle{
    val CSRDe = new CSRDeIO
    val CSRWb = new CSRWbIO
    val CSRTr = new CSRTrapIO

    val timer_int = Input(Bool())
    val clear_mip = Input(Bool())
}

class CSRs extends Module{
    val io = IO(new CSRIO)

    //内部逻辑
    //定义csr
    val MTVEC = RegInit(0.U(X_LEN.W))
    val MCAUSE = RegInit(0.U(X_LEN.W))
    val MEPC = RegInit(0.U(X_LEN.W))
    val MIE = RegInit(0.U(X_LEN.W))
    val MIP = RegInit(0.U(X_LEN.W))
    val MSTATUS = RegInit(0.U(X_LEN.W))
    val MSCRATCH = RegInit(0.U(X_LEN.W))

    when(io.clear_mip){ //写mtimecmp后,需要清除
        MIP := Cat(MIP(63,8), 0.U, MIP(6,0))
    }
    .elsewhen(io.timer_int){   //定时器中断等待处理
        MIP := Cat(MIP(63,8), 1.U, MIP(6,0))
    }

    switch(io.CSRWb.rd | io.CSRTr.rd){
        is(MTVEC_ADDR.U){  
            MTVEC := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MTVEC)  //修改末项,不应该为0
                )
        }
        is(MCAUSE_ADDR.U){
            MCAUSE := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MCAUSE)
                )
        }
        is(MEPC_ADDR.U){
            MEPC := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MEPC)
                )
        }
        is(MIE_ADDR.U){
            MIE := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MIE)
                )
        }
        is(MIP_ADDR.U){
            MIP := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MIP)
                )
        }
        is(MSTATUS_ADDR.U){
            MSTATUS := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MSTATUS)
                )
        }
        is(MSCRATCH_ADDR.U){
            MSCRATCH := Mux(io.CSRWb.csr_wen, io.CSRWb.csr_wdata, 
                Mux(io.CSRTr.csr_wen, io.CSRTr.csr_wdata, MSCRATCH)
                )
        }
    }

    
    //端口驱动
    io.CSRDe.csr_rdata := MuxLookup(
        io.CSRDe.csr_raddr,
        0.U,
        Seq(
            MTVEC_ADDR.U -> MTVEC,
            MCAUSE_ADDR.U -> MCAUSE,
            MEPC_ADDR.U -> MEPC,
            MIE_ADDR.U -> MIE,
            MIP_ADDR.U -> MIP,
            MSTATUS_ADDR.U -> MSTATUS,
            MSCRATCH_ADDR.U -> MSCRATCH
        )
    )

    io.CSRTr.MCAUSE := MCAUSE
    io.CSRTr.MEPC := MEPC
    io.CSRTr.MIE := MIE
    io.CSRTr.MIP := MIP
    io.CSRTr.MSTATUS := MSTATUS
    io.CSRTr.MTVEC := MTVEC



}
