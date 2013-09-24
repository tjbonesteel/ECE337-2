module rcu
  (
  input wire clk,
  input wire n_rst,
  input wire start_bit_detected,
  input wire packet_done,
  input wire framing_error,
  output reg sbc_clear,
  output reg sbc_enable,
  output reg load_buffer,
  output reg enable_timer
  );
  
  typedef enum bit [1:0] {IDLE, READ, CHK, LOAD} state_type;
  state_type state, nextstate;
  
  
  always@(posedge clk, negedge n_rst) begin : Reset_Logic
    if(1'b0 == n_rst) begin
      state <= IDLE;
    end else begin
      state <= nextstate;
    end
  end
  
  always @ (state, start_bit_detected, packet_done, framing_error) begin : State_Logic
    nextstate = state;
    
    case(state)
      IDLE: begin
        if(start_bit_detected == 1'b0) begin
          nextstate = IDLE;
        end else begin
          nextstate = READ;
        end
      end
      
      READ: begin
        if(packet_done == 1'b0) begin
          nextstate = READ;
        end else begin
          nextstate = CHK;
        end
      end
      
      CHK: begin
        if(framing_error == 1'b0) begin
          nextstate = LOAD;
        end else begin
          nextstate = IDLE;
        end
      end
      
      LOAD: begin
        nextstate = IDLE;
      end
    endcase
  end
  
  
  always @ (state) begin : Register_Logic
    case(state)
      IDLE: begin
        sbc_clear = 1'b0;
        sbc_enable = 1'b0;
        load_buffer = 1'b0;
        enable_timer = 1'b0;
      end
      
      READ: begin
        sbc_clear = 1'b1;
        sbc_enable = 1'b0;
        load_buffer = 1'b0;
        enable_timer = 1'b1;
      end
      
      CHK: begin
        sbc_clear = 1'b0;
        sbc_enable = 1'b1;
        load_buffer = 1'b0;
        enable_timer = 1'b0;
      end
      
      LOAD: begin
        sbc_clear = 1'b0;
        sbc_enable = 1'b0;
        load_buffer = 1'b1;
        enable_timer = 1'b0;
      end
 	default: begin
	sbc_clear = 1'b0;
        sbc_enable = 1'b0;
        load_buffer = 1'b0;
        enable_timer = 1'b0;
      end
    endcase
  end

endmodule
