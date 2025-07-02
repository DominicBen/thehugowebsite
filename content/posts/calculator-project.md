---
title: "Calculator Project"
date: 2022-06-25T21:08:38-04:00
draft: false
featuredImage: "/assets/calculator/image_36.png"
authors: ["Dominic"]
---
> **Contributors**: Dominic Benintendi (Parser/Lexer, System Architecture)
> Devin Macy (Input Handling, LCD/Keypad Logic)
> Colin Russell (Documentation, UI Design)
> AL-Husain Bani Oraba (Schematics, Requirements)  
> **GitHub Repository**: [devin-macy/senior-design-calculator](https://github.com/devin-macy/senior-design-calculator)

# Introduction

This project involved designing and implementing a fully functional four-function calculator using an Arduino Nano. The goal was to build a robust, extensible, and user-friendly device that mimicked the behavior of standard calculators while operating within microcontroller constraints. Key features included expression parsing, syntax validation, floating-point arithmetic, and input history navigation.

# Background and Objectives

Created as part of the EE4953 course in Fall 2022, this calculator extended beyond basic arithmetic to include exponentiation, parentheses, and floating-point support. The system was designed to be object-oriented, modular, and error-resilient, with a custom-built recursive descent parser and real-time LCD output.

{{< figure src="/assets/calculator/image_16.png" alt="Calculator overview" width="600" >}}

# Methods

## Hardware Design

The device was constructed with the following components:

- **Microcontroller**: Arduino Nano  
- **Display**: 1602 LCD module using I2C interface  
- **Input**: 4x4 membrane keypad with two external shift buttons  
- **Power**: 5V via USB Mini-B  

{{< figure src="/assets/calculator/image_8.png" alt="Arduino Nano and components" width="600" >}}  
{{< figure src="/assets/calculator/image_18.png" alt="1602 LCD" width="600" >}}  
{{< figure src="/assets/calculator/image_20.png" alt="Membrane Keypad" width="600" >}}

## Input Modes and Key Mapping

Due to the limited key count, shift-based modes were implemented:

- **Default Mode**: `A–D` map to `+ – × ÷`, with `=` and `Clear` mapped to dedicated keys  
- **Left Shift Mode**: Arrow keys, Insert, Delete  
- **Right Shift Mode**: Parentheses, decimal, exponentiation, Clear All

{{< figure src="/assets/calculator/image_33.png" alt="Default Keymap" width="600" >}}  
{{< figure src="/assets/calculator/image_5.png" alt="Left Shift Mode" width="600" >}}  
{{< figure src="/assets/calculator/image_17.png" alt="Right Shift Mode" width="600" >}}

## Software Architecture

The software stack was divided into modular components:

- **CalcLexer**: Tokenizes user input into meaningful elements  
- **CalcParser**: Recursively evaluates expressions with proper precedence  
- **LcdController**: Formats and displays expressions and results  
- **KeypadController**: Handles raw input, shift state, and cursor navigation

This modular approach ensures scalability and maintainability.

# Results

## System Capabilities

- Full arithmetic expression evaluation with support for:
  - Parentheses
  - Exponents
  - Floating-point numbers
- Real-time syntax validation
- Scrollable input editing
- History-based navigation for recent expressions
- Dual-clear modes (single line and full reset)

## Evaluation Environment

- Operates in environments between –40°F and 185°F  
- Optimal humidity range: 40% ± 30%  
- No chassis—device is sensitive to physical impact or moisture  
- Requires 5V USB power only

# Expression Parsing and Evaluation

To support complex expressions, the system implements a **custom lexer and recursive descent parser**.

### Tokenization

The lexer converts raw input into structured tokens:

- **Token Types**: `NUM`, `ADD`, `SUB`, `MUL`, `DIV`, `POW`, `L_PAR`, `R_PAR`, `END`

**Example Input**: `"5 / (6 + 2)"`  
**Tokenized**: `NUM DIV L_PAR NUM ADD NUM R_PAR`

{{< figure src="/assets/calculator/image_46.png" alt="Lexer Output" width="600" >}}

### Recursive Descent Parser

The parser respects order of operations and grouping using the following grammar:

```

Operand        → NUM
EXP            → Operand | L\_PAR ADD\_SUB\_EXP R\_PAR | SUB ADD\_SUB\_EXP
POW\_EXP        → EXP POW EXP | EXP
MUL\_DIV\_EXP    → POW\_EXP (MUL | DIV) POW\_EXP | POW\_EXP
ADD\_SUB\_EXP    → MUL\_DIV\_EXP (ADD | SUB) MUL\_DIV\_EXP | MUL\_DIV\_EXP

```

This design supports:

- Operator precedence (`^` > `× ÷` > `+ –`)  
- Left- and right-associative rules  
- Unary negation (e.g., `-5`, `2 + -6`)  
- Floating-point precision

{{< figure src="/assets/calculator/image_31.png" alt="Parser Flow" width="600" >}}

### Error Handling

Robust validation was built in to detect:

- **Syntax Errors**: `ERR:SYNTAX`  
- **Division by Zero**: `ERR:DIV BY 0`  
- **Floating Point Errors**: `ERR:DECM SYNTAX`  
- **Unmatched Parentheses**: `ERR:NO R_PAR`

### Sample Evaluations

```

Input: 5 + 3 \* 5       → Output: 20

```
{{< figure src="/assets/calculator/image_7.png" alt="Sample Evaluation 1" width="600" >}}

```

Input: (5 + 3) \* 5     → Output: 40

```
{{< figure src="/assets/calculator/image_24.png" alt="Sample Evaluation 2" width="600" >}}

```

Input: 5 \* ((4 - 5)/0.5) → Output: -10

```
{{< figure src="/assets/calculator/image_1.png" alt="Sample Evaluation 3" width="600" >}}

# Conclusion

This project demonstrates the practical implementation of advanced parsing logic and real-time arithmetic evaluation on embedded hardware. With limited input hardware and display space, the system still supports complex expressions and interactive editing. The modular architecture and extensible design open pathways for additional features such as scientific functions, graphical output, or external model loading in future iterations.


## References

- [stb_image](https://github.com/nothings/stb/blob/master/stb_image.h) – Image parsing (used in related projects)  
- [TinkerCAD](https://www.tinkercad.com/) – Schematic design  
- [Arduino Nano](https://store.arduino.cc/products/arduino-nano) – Microcontroller documentation

