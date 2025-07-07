`timescale 1ns / 1ps  // Definición de escala de tiempo
`include "src/BCDtoSSeg.v"

module BCDtoSSeg_tb;
    // Declaración de señales
    reg [3:0] BCD;     // Entrada BCD (4 bits)
    wire [0:6] SSeg;   // Salida del display de 7 segmentos
    wire [3:0] an;     // Activación de ánodos (siempre 1110 en tu diseño)

    // Instanciar el módulo bajo prueba
    BCDtoSSeg uut (
        .BCD(BCD),
        .SSeg(SSeg),
        .an(an)
    );

    // Generar archivo VCD para visualización en GTKWave
    initial begin
        $dumpfile("BCDtoSSeg_tb.vcd");
        $dumpvars(0, BCDtoSSeg_tb);
    end

    // Bloque de estímulos
    initial begin
        // Caso 1: Mostrar "0" (BCD = 0000)
        BCD = 4'b0000;
        #10;
        $display("BCD = %b (0) => SSeg = %b (Segmentos activos: a)", BCD, SSeg);

        // Caso 2: Mostrar "5" (BCD = 0101)
        BCD = 4'b0101;
        #10;
        $display("BCD = %b (5) => SSeg = %b (Segmentos activos: f,g,c,d)", BCD, SSeg);

        // Caso 3: Mostrar "9" (BCD = 1001)
        BCD = 4'b1001;
        #10;
        $display("BCD = %b (9) => SSeg = %b (Segmentos activos: a,b,c,f,g)", BCD, SSeg);

        // Caso 4: Mostrar "A" (BCD = 1010)
        BCD = 4'b1010;
        #10;
        $display("BCD = %b (A) => SSeg = %b (Segmentos activos: a,b,c,e,f,g)", BCD, SSeg);

        // Finalizar simulación
        $finish;
    end
endmodule