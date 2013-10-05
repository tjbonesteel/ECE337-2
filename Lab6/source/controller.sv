module controller
	(
	input wire clk,
	input wire n_rst,
	input wire stop_found,
	input wire start_found,
	input wire byte_received,
	input wire ack_prep,
	input wire check_ack,
	input wire ack_done,
	input wire rw_mode,
	input wire address_match,
	input wire sda_in,
	output reg rx_enable,
	output reg tx_enable,
	output reg read_enable,
	output reg sda_mode [1:0],
	load_data
	);

	typedef enum bit [4:0] {IDLE,CHECKADDRESS, WAITADDRESS, SENDNACK, SENDACK, LOADDATA, SENDDATA, STOPDATA, CHECKACK, RECNACK, RECACK } state_type;
	state_type state, nextstate;

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 1'b0) begin
			state <= IDLE;
		end else begin
			state <= nextstate;
		end
	end

  always @ (state, stop_found, start_found, byte_received, ack_prep, check_ack, ack_done, rw_mode, address_match, sda_in ) begin : State_Logic
	nextstate = state;
  
  case(state)
    IDLE: begin
      if (start_found == 1'b1) 
        nextstate <= CHECKADDRESS;
      else
        nextstate <= IDLE;
      end
    end

    CHECKADDRESS: begin
      if (ack_prep == 1'b1)
        nextstate <= WAITADDRESS;
      else
        nextstate <= CHECKADDRESS;
      end
    end

    WAITADDRES: begin
      if (address_match == 1'b1 && rw_mode == 1'b1)
        nextstate <= SENDACK;
      else if (address_match == 1'b0 && rw_mode = 1'b0)
        nextstate <= SENDNACK;
      else
        nextstate <= SENDNACK;
        $assert(" Address = 0 and rw mode = 1");
      end
    end

    SENDACK: begin
      if (ack_done == 1'b1)
        nextstate <= LOADDATA;
      else
        nextstate <= SENDACK;
      end
    end

    SENDNACK: begin
      if (ack_done == 1'b1)
        nextstate <= IDLE;
      else
        nextstate <= SENDNACK;
      end
    end

    LOADDATA: begin
      nextstate <= SENDDATA;
    end

    SENDDATA: begin
      if (byte_received == 1'b1) //or ack_prep
        nextstate <= STOPDATA;
      else
        nextstate <= SENDDATA;
      end
    end

    STOPDATA: begin
      if (check_ack == 1'b1)
        nextstate <= CHECKACK;
      else
        nextstate <= STOPDATA;
      end
    end

    CHECKACK: begin
      if (ack_done == 1'b1 && sda_in == 1'b0)
        nextstate <= RECACK;
      else if (ack_done == 1'b1 && sda_in == 1'b1)
        nextstate <= RECNACK;
      end
    end

    RECACK: begin
      nextstate <= LOADDATA;
    end

    RECNACK: begin
      if (stop_found == 1'b1)
        nextstate <= CHECKADDRESS;
      else if (stop_found == 1'b0)
        nextstate <= IDLE;
      end
    end
  endcase
	end

  always @ (state) begin : Output_Logic
  case(state)

    IDLE: begin
      rx_enable = 1'b1;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    CHECKADDRESS: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    WAITADDRES: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    SENDACK: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b01;
      load_data = 1'b0;
    end

    SENDNACK: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b10;
      load_data = 1'b0;
    end

    LOADDATA: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b1;
    end

    SENDDATA: begin
      rx_enable = 1'b0;
      tx_enable = 1'b1;
      read_enable = 1'b0;
      sda_mode = 2'b11;
      load_data = 1'b0;
    end

    STOPDATA: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    CHECKACK: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    RECACK: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b1;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

    RECNACK: begin
      rx_enable = 1'b0;
      tx_enable = 1'b0;
      read_enable = 1'b0;
      sda_mode = 2'b00;
      load_data = 1'b0;
    end

  endcase
	end







