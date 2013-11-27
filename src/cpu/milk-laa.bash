#!/bin/bash

# $1 being one from jmp-commands.txt, move-commands.txt,laa-commands.txt
awk -F"\t" 'BEGIN { while (getline < "named-commands.txt") { file1[$1]=$3;} 
split("imp imm zp zpx zpy izx izy abs abx aby ind rel", adrmodes, " "); 
} 

{    
for( i=2; i<14; i++){ 
   if($i~"^\$"){
#printf("%s desc: %s opcode: %s adrm: %s action: %s flags: %s%s%s%s%s%s%s\n", $1, file1[$1], $i, adrmodes[i], $14 , $15,$16,$17,$18,$19,$20,$21,$22);}
       printf("%s|%s|%s|%s|%s%s%s%s%s%s%s%s|%s\n", $1, substr($i,2,3), adrmodes[i], $14 , $15,$16,$17,$18,$19,$20,$21,$22,file1[$1]);}
   }
}' $1

# | awk -F"|" '{printf("\n{ \"%s\", 0x%02x, \"%s\", cpu_6502_%s_%s, \"%s\" ,\"%s\", \"%s\" },", $1, $2, $3,$1, $3, $4,$6,$5)}'

#
# script generates this table:
# 
# { "ORA", 0x09, "zp", cpu_6502_ORA_zp, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x05, "zpx", cpu_6502_ORA_zpx, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x0f, "zpy", cpu_6502_ORA_zpy, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x01, "izy", cpu_6502_ORA_izy, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x0b, "abs", cpu_6502_ORA_abs, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x00, "abx", cpu_6502_ORA_abx, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x01, "aby", cpu_6502_ORA_aby, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "ORA", 0x13, "ind", cpu_6502_ORA_ind, "A:=A or {adr} " ,"or with accumulator", "*    * " },
# { "AND", 0x1d, "zp", cpu_6502_AND_zp, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x19, "zpx", cpu_6502_AND_zpx, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x23, "zpy", cpu_6502_AND_zpy, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x15, "izy", cpu_6502_AND_izy, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x1f, "abs", cpu_6502_AND_abs, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x02, "abx", cpu_6502_AND_abx, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x03, "aby", cpu_6502_AND_aby, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "AND", 0x27, "ind", cpu_6502_AND_ind, "A:=A&{adr} " ,"and (with accumulator)", "*    * " },
# { "EOR", 0x31, "zp", cpu_6502_EOR_zp, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x2d, "zpx", cpu_6502_EOR_zpx, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x37, "zpy", cpu_6502_EOR_zpy, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x29, "izy", cpu_6502_EOR_izy, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x33, "abs", cpu_6502_EOR_abs, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x04, "abx", cpu_6502_EOR_abx, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x05, "aby", cpu_6502_EOR_aby, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "EOR", 0x3b, "ind", cpu_6502_EOR_ind, "A:=A exor {adr} " ,"exclusive or (with accumulator)", "*    * " },
# { "ADC", 0x45, "zp", cpu_6502_ADC_zp, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x41, "zpx", cpu_6502_ADC_zpx, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x4b, "zpy", cpu_6502_ADC_zpy, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x3d, "izy", cpu_6502_ADC_izy, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x47, "abs", cpu_6502_ADC_abs, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x06, "abx", cpu_6502_ADC_abx, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x07, "aby", cpu_6502_ADC_aby, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "ADC", 0x4f, "ind", cpu_6502_ADC_ind, "A:=A+{adr} " ,"add with carry", "**   **" },
# { "SBC", 0x00, "zp", cpu_6502_SBC_zp, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "zpx", cpu_6502_SBC_zpx, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "zpy", cpu_6502_SBC_zpy, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "izy", cpu_6502_SBC_izy, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "abs", cpu_6502_SBC_abs, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "abx", cpu_6502_SBC_abx, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "aby", cpu_6502_SBC_aby, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "SBC", 0x00, "ind", cpu_6502_SBC_ind, "A:=A-{adr} " ,"subtract with carry", "**   **" },
# { "CMP", 0x00, "zp", cpu_6502_CMP_zp, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "zpx", cpu_6502_CMP_zpx, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "zpy", cpu_6502_CMP_zpy, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "izy", cpu_6502_CMP_izy, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "abs", cpu_6502_CMP_abs, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "abx", cpu_6502_CMP_abx, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "aby", cpu_6502_CMP_aby, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CMP", 0x00, "ind", cpu_6502_CMP_ind, "A-{adr} " ,"compare (with accumulator)", "*    **" },
# { "CPX", 0x00, "zp", cpu_6502_CPX_zp, "X-{adr} " ,"compare with X", "*    **" },
# { "CPX", 0x00, "zpx", cpu_6502_CPX_zpx, "X-{adr} " ,"compare with X", "*    **" },
# { "CPX", 0x00, "abx", cpu_6502_CPX_abx, "X-{adr} " ,"compare with X", "*    **" },
# { "CPY", 0x00, "zp", cpu_6502_CPY_zp, "Y-{adr} " ,"compare with Y", "*    **" },
# { "CPY", 0x00, "zpx", cpu_6502_CPY_zpx, "Y-{adr} " ,"compare with Y", "*    **" },
# { "CPY", 0x00, "abx", cpu_6502_CPY_abx, "Y-{adr} " ,"compare with Y", "*    **" },
# { "DEC", 0x00, "zpx", cpu_6502_DEC_zpx, "{adr}:={adr}-1 " ,"decrement", "*    * " },
# { "DEC", 0x00, "zpy", cpu_6502_DEC_zpy, "{adr}:={adr}-1 " ,"decrement", "*    * " },
# { "DEC", 0x00, "abx", cpu_6502_DEC_abx, "{adr}:={adr}-1 " ,"decrement", "*    * " },
# { "DEC", 0x00, "aby", cpu_6502_DEC_aby, "{adr}:={adr}-1 " ,"decrement", "*    * " },
# { "DEX", 0x00, "imm", cpu_6502_DEX_imm, "X:=X-1 " ,"decrement X", "*    * " },
# { "DEY", 0x58, "imm", cpu_6502_DEY_imm, "Y:=Y-1 " ,"decrement Y", "*    * " },
# { "INC", 0x00, "zpx", cpu_6502_INC_zpx, "{adr}:={adr}+1 " ,"increment", "*    * " },
# { "INC", 0x00, "zpy", cpu_6502_INC_zpy, "{adr}:={adr}+1 " ,"increment", "*    * " },
# { "INC", 0x00, "abx", cpu_6502_INC_abx, "{adr}:={adr}+1 " ,"increment", "*    * " },
# { "INC", 0x00, "aby", cpu_6502_INC_aby, "{adr}:={adr}+1 " ,"increment", "*    * " },
# { "INX", 0x00, "imm", cpu_6502_INX_imm, "X:=X+1 " ,"increment X", "*    * " },
# { "INY", 0x00, "imm", cpu_6502_INY_imm, "Y:=Y+1 " ,"increment Y", "*    * " },
# { "ASL", 0x00, "imm", cpu_6502_ASL_imm, "{adr}:={adr}*2 " ,"arithmetic shift left", "*    **" },
# { "ASL", 0x06, "zpx", cpu_6502_ASL_zpx, "{adr}:={adr}*2 " ,"arithmetic shift left", "*    **" },
# { "ASL", 0x10, "zpy", cpu_6502_ASL_zpy, "{adr}:={adr}*2 " ,"arithmetic shift left", "*    **" },
# { "ASL", 0x00, "abx", cpu_6502_ASL_abx, "{adr}:={adr}*2 " ,"arithmetic shift left", "*    **" },
# { "ASL", 0x01, "aby", cpu_6502_ASL_aby, "{adr}:={adr}*2 " ,"arithmetic shift left", "*    **" },
# { "ROL", 0x02, "imm", cpu_6502_ROL_imm, "{adr}:={adr}*2+C " ,"rotate left", "*    **" },
# { "ROL", 0x1a, "zpx", cpu_6502_ROL_zpx, "{adr}:={adr}*2+C " ,"rotate left", "*    **" },
# { "ROL", 0x24, "zpy", cpu_6502_ROL_zpy, "{adr}:={adr}*2+C " ,"rotate left", "*    **" },
# { "ROL", 0x02, "abx", cpu_6502_ROL_abx, "{adr}:={adr}*2+C " ,"rotate left", "*    **" },
# { "ROL", 0x03, "aby", cpu_6502_ROL_aby, "{adr}:={adr}*2+C " ,"rotate left", "*    **" },
# { "LSR", 0x04, "imm", cpu_6502_LSR_imm, "{adr}:={adr}/2 " ,"logical shift right", "*    **" },
# { "LSR", 0x2e, "zpx", cpu_6502_LSR_zpx, "{adr}:={adr}/2 " ,"logical shift right", "*    **" },
# { "LSR", 0x38, "zpy", cpu_6502_LSR_zpy, "{adr}:={adr}/2 " ,"logical shift right", "*    **" },
# { "LSR", 0x04, "abx", cpu_6502_LSR_abx, "{adr}:={adr}/2 " ,"logical shift right", "*    **" },
# { "LSR", 0x05, "aby", cpu_6502_LSR_aby, "{adr}:={adr}/2 " ,"logical shift right", "*    **" },
# { "ROR", 0x06, "imm", cpu_6502_ROR_imm, "{adr}:={adr}/2+C*128 " ,"rotate right", "*    **" },
# { "ROR", 0x42, "zpx", cpu_6502_ROR_zpx, "{adr}:={adr}/2+C*128 " ,"rotate right", "*    **" },
# { "ROR", 0x4c, "zpy", cpu_6502_ROR_zpy, "{adr}:={adr}/2+C*128 " ,"rotate right", "*    **" },
# { "ROR", 0x06, "abx", cpu_6502_ROR_abx, "{adr}:={adr}/2+C*128 " ,"rotate right", "*    **" },
# { "ROR", 0x07, "aby", cpu_6502_ROR_aby, "{adr}:={adr}/2+C*128 " ,"rotate right", "*    **" },
