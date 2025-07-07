module top_display (
    input wire clk,
    input wire reset,
    input wire sel_display,
    input wire [15:0] valor_bcd,  // 4 dígitos BCD (4 bits cada uno)
    output wire [6:0] sseg,
    output wire [3:0] an
);

    // Mux para seleccionar el dígito BCD actual
    wire [3:0] bcd_actual;
    assign bcd_actual = (sel_display == 0) ? valor_bcd[3:0] :
                       (sel_display == 1) ? valor_bcd[7:4] :
                       (sel_display == 2) ? valor_bcd[11:8] :
                       valor_bcd[15:12];
    
    // Decodificador de ánodo (convierte sel[1:0] a one-hot)
    wire [3:0] anodo_sel;
    assign anodo_sel = ~(1 << sel_display);  // Activación baja
    
    // Instancia de tu conversor BCD a 7 segmentos
    BCDtoSSeg conversor (
        .BCD(bcd_actual),
        .s(anodo_sel),
        .SSeg(sseg),
        .an(an)
    );

endmodule