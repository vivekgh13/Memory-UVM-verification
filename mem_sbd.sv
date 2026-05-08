class mem_sbd extends uvm_subscriber#(mem_tx);

`uvm_component_utils(mem_sbd)

mem_tx tx;

int match_count;
int mis_match_count;

bit [`WIDTH-1:0] sbd_mem[*];

function new(string name="",uvm_component parent);
super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

function void write(mem_tx t);
  $cast(tx,t);
  if(tx.wr_rd==1) begin 
    sbd_mem[tx.addr]=tx.wdata;
  end
    else begin
      if (tx.rdata==sbd_mem[tx.addr]) begin
      match_count++;
      `uvm_info("mem_sbd",$sformatf("at addr=%h actual data=%h is      matching with expected data=%h",tx.addr,tx.rdata,sbd_mem[tx.addr]),UVM_NONE);
    end
    else begin
      mis_match_count++;
     `uvm_error("meem_sbd",$sformatf("at addr=%h actual data=%h is not matching with expected data=%h",
                                  tx.addr,tx.rdata,sbd_mem[tx.addr]));
    end
  end
endfunction

endclass
