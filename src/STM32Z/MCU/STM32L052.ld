/* Define memory regions. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

/* Enforce emmition of the vector table. */
EXTERN(vector_table)

/* Define the entry point of the output file. */
ENTRY(resetHandler)

PROVIDE(_estack = ORIGIN(RAM) + LENGTH(RAM));

/* Define sections. */
SECTIONS
{
  .vector : {
    *(.vector*)  /* Vector table */
  } >FLASH

  .text : {
    . = ALIGN(4);
    *(.text*)  /* Program code */
    . = ALIGN(4);
    *(.rodata*)  /* Read-only data */
  } >FLASH

  . = ALIGN(4);
  _etext = .;

  /* ram, but not cleared on reset, eg boot/app comms */
  .noinit (NOLOAD) : {
    *(.noinit*)
  } >RAM
  . = ALIGN(4);

  .data : {
    _data = .;
    *(.data*)  /* Read-write initialized data */
    *(.ramtext*)    /* "text" functions to run in ram */
    . = ALIGN(4);
    _edata = .;
  } >RAM AT >FLASH
  _data_loadaddr = LOADADDR(.data);

  .bss : {
    _bss = .;
    *(.bss*)  /* Read-write zero initialized data */
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
  } >RAM

  . = ALIGN(4);
  end = .;
}
