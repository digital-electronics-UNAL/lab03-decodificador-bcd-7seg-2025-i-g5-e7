module Div_frecuencia (
    input wire clk,         // Señal de reloj de entrada (ej. 50MHz)
    input wire reset,       // Señal de reset
    output wire clk_out,    // Señal de reloj de salida (dividida)
    output reg [1:0] sel    // Selector de display (0-3)
);

    // Parámetros para división de frecuencia
    parameter FRECUENCIA_RELOJ = 50_000_000;  // 50MHz
    parameter TIEMPO_REFRESCO = 16;           // 16ms por display
    parameter NUM_DISPLAYS = 4;              // 4 displays
    
    // Cálculo del divisor para lograr 16ms por display
    localparam DIVISOR = (FRECUENCIA_RELOJ * TIEMPO_REFRESCO) / (1000 * NUM_DISPLAYS);
    localparam ANCHO_CONTADOR = $clog2(DIVISOR);
    
    // Registros internos
    reg [ANCHO_CONTADOR-1:0] contador;
    reg clk_out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            contador <= 0;
            clk_out_reg <= 0;
            sel <= 0;
        end
        else begin
            if (contador == DIVISOR - 1) begin
                contador <= 0;
                clk_out_reg <= ~clk_out_reg;
                sel <= sel + 1;  // Rotación entre displays 0-3
            end
            else begin
                contador <= contador + 1;
            end
        end
    end
    
    assign clk_out = clk_out_reg;

endmodule