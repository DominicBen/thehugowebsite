---
title: "Calculator Project"
date: 2022-06-25T21:08:38-04:00
draft: false
featuredImage: "/assets/calculator/image_36.png"
authors: ["Dominic"]
---

# Four-Function Calculator  
**EE4953 Project | Fall 2022**  
[GitHub Repository](https://github.com/devin-macy/senior-design-calculator)

## Team Members
- **Dominic Benintendi** – Parser/Lexer development, system architecture
- **Devin Macy** – LCD/keypad logic, input handling, shift/button mappings
- **Colin Russell** – Documentation, user guide, interface design
- **AL-Husain Bani Oraba** – Diagrams, system requirements, documentation support

## Overview
{{< figure src="/assets/calculator/image_16.png" alt="Hardness for lasers" width="600" >}}
I designed and built a fully functional four-function calculator using an Arduino Nano, 1602 LCD, and a 4x4 membrane keypad. The goal was to create a reliable and user-friendly device that adheres to the standard conventions of modern calculators while operating within hardware constraints.

## Features
- Arithmetic: Add, subtract, multiply, divide
- Extra operations: Parentheses, exponents, floating point
- Syntax error handling with helpful messages
- Expression editing with arrow keys, insert/delete
- History navigation for past expressions
- Dual clear functionality: `Clear` and `Clear All`

## Hardware
- **Microcontroller:** Arduino Nano  
{{< figure src="/assets/calculator/image_8.png" alt="Hardness for lasers" width="600" >}}
- **Display:** 1602 LCD via I2C  
{{< figure src="/assets/calculator/image_18.png" alt="Hardness for lasers" width="600" >}}
- **Input:** 4x4 membrane keypad + 2 shift pushbuttons  
{{< figure src="/assets/calculator/image_20.png" alt="Hardness for lasers" width="600" >}}
- **Power:** 5V via USB Mini-B

## Keypad Mapping
- **Mode Switching:** Due to the limited number of keys on the keypad, mode switching was used
- **Default Mode:** `A–D` → `+ - * /`, adjacent key → `=`, lower left → `Clear`
{{< figure src="/assets/calculator/image_33.png" alt="Hardness for lasers" width="600" >}}
- **Left Shift Mode (L):** Arrow keys, `del`, `ins`
{{< figure src="/assets/calculator/image_5.png" alt="Hardness for lasers" width="600" >}}
- **Right Shift Mode (R):** `()`, `.`, `^`, `Clear All`
{{< figure src="/assets/calculator/image_17.png" alt="Hardness for lasers" width="600" >}}

## Software
- **Input parsing:** Lexer/tokenizer and recursive descent parser
- **Computation:** Infix notation with proper order of operations
- **Display logic:** Shows expressions and results with context-aware alignment
- **Error handling:** Returns messages like `ERR:SYNTAX`, `ERR:DIV BY 0`, etc.



## System Design
- **Modules:** 
  - `CalcLexer` – Tokenizes user input
  - `CalcParser` – Recursively evaluates expressions
  - `LcdController` – Manages LCD content
  - `KeypadController` – Maps key inputs and shift states

- **Architecture:** Clean object-oriented design with clearly divided subsystems for input, display, and computation.

## Build Diagrams
- TinkerCAD schematic of the system
- Breadboard and wiring layouts
- LCD and keypad pin connections
- Flowcharts for data processing and system interaction

## Operating Notes
- Operates in 40%±30% humidity and –40°F to 185°F
- Not resistant to drops or moisture—no protective chassis
- Powered exclusively via USB





## Expression Evaluation: Lexer & Parser

To support full arithmetic expressions (including parentheses, exponents, and floating-point numbers), we developed a **custom recursive descent parser** backed by a **lexer/tokenizer**. This allowed us to move beyond simple two-number operations and handle full algebraic expressions with correct operator precedence and error detection.

### 🔍 Lexer (Tokenizer)
{{< figure src="/assets/calculator/image_46.png" alt="Hardness for lasers" width="600" >}}
The lexer scans the raw input string and converts it into a stream of tokens. These tokens represent numbers, operators (`+`, `-`, `*`, `/`, `^`), parentheses, and the end of the expression.

**Token types included:**
- `NUM`: Any numeric value (integer or float)
- `ADD`, `SUB`, `MUL`, `DIV`, `POW`: Arithmetic operators
- `L_PAR`, `R_PAR`: Left and right parentheses
- `END`: End of expression

**Example:**
```
Input: "5 / (6 + 2)"
Tokens: NUM DIV L_PAR NUM ADD NUM R_PAR
```

### 🧠 Parser (Recursive Descent)
{{< figure src="/assets/calculator/image_31.png" alt="Hardness for lasers" width="600" >}}
The parser evaluates the token stream using a **context-free grammar** with recursion to respect the order of operations:

```
Operand:
  → **NUM**

EXP:
  → Operand
  | **LEFT_PAR** ADD_SUB_EXP **RIGHT_PAR**
  | **SUB** ADD_SUB_EXP

POW_EXP:
  → EXP **POW** EXP
  | EXP

MUL_DIV_EXP:
  → POW_EXP **MUL** POW_EXP
  | POW_EXP **DIV** POW_EXP
  | POW_EXP

ADD_SUB_EXP:
  → MUL_DIV_EXP **ADD** MUL_DIV_EXP
  | MUL_DIV_EXP **SUB** MUL_DIV_EXP
  | MUL_DIV_EXP
```

This approach supports:
- Proper **precedence**: `*` and `/` before `+` and `-`, and `^` before both
- **Associativity**: Left-to-right for most ops, right-to-left for `^`
- **Parentheses** for grouping
- **Negative numbers** and **unary minus** (e.g., `-5`, `2 + -6`)
- **Floating point precision** with 2-decimal accuracy on LCD

### 🛠 Error Handling
The lexer/parser combination detects and reports:
- `ERR:SYNTAX` – Invalid token arrangement
- `ERR:DIV BY 0` – Division by zero
- `ERR:DECM SYNTAX` – Multiple decimal points in a number
- `ERR:NO R_PAR` – Missing closing parenthesis

### 🧪 Sample Evaluations

``` 
Input: 5 + 3 * 5 → Output: 20 (Multiplication before addition) 
```
{{< figure src="/assets/calculator/image_7.png" alt="Calculation Example 1" width="600" >}}
```
Input: (5 + 3) * 5 → Output: 40 (Parentheses override precedence)
```
{{< figure src="/assets/calculator/image_24.png" alt="Calculation Example 2" width="600" >}}
```
Input: 5 * ((4 - 5)/0.5) → Output: -10 (Nested expressions + float division)
```
{{< figure src="/assets/calculator/image_1.png" alt="Calculation Example 3" width="600" >}}

---

