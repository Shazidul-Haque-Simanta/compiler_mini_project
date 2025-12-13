# Compiler Mini Project

A **mini compiler project** developed for **academic purposes**, demonstrating core concepts of **compiler design** such as lexical analysis, parsing, and basic semantic handling using a custom, Bangla-inspired programming syntax.

---

## 📌 Project Overview

This project implements a simple compiler/interpreter for a toy programming language that uses **Bangla keywords** for better readability and learning. It is intended for:

* Compiler Design coursework
* Understanding parsing techniques (LR / related concepts)
* Academic demonstrations and experimentation

---

## ✨ Language Features

The custom language supports:

* Variable declaration (`dhori`)
* Arithmetic operations (`jog`, etc.)
* Conditional statements (`jodi`, `othoba`)
* Equality comparison (`soman`)
* Output statements (`dekhao`)

### 🔹 Example Code

```text
dhori x 10;
dhori y 15;
dekhao x jog y;

jodi x soman 10 hoy {
    dekhao "x_is_10";
    x soman x jog 5;
    dekhao x;
} othoba {
    dekhao "x_is_not_10";
}
```

---

## 🛠️ Technologies Used

* Programming Language: C / C++ (depending on implementation)
* Compiler Concepts:

  * Lexical Analysis
  * Syntax Analysis (Parsing)
  * Symbol Table Handling
* Tools:

  * Flex / Lex (if used)
  * Bison / Yacc (if used)

---

## 🚀 How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/Shazidul-Haque-Simanta/compiler_mini_project.git
   ```

2. Navigate to the project directory:

   ```bash
   cd compiler_mini_project
   ```

3. Compile the source code (example):

   ```msys_mingw64
   bison -d parser.y
   flex lexer.l
   gcc -o shazid_output lex.yy.c parser.tab.c
   
   
   ```

4. Run the compiler/interpreter:

   ```msys_mingw64
   ./shazid_output  < input.txt
   ```

---

## 🎓 Academic Use Notice

This project is intended **strictly for educational and academic purposes**.

* You may study, modify, and experiment with the code
* You must give proper credit to the author
* Commercial use is **not allowed** without explicit permission

See the [LICENSE](LICENSE) file for full details.

---

## 👤 Author

**Shazidul Haque Simanta**
Daffodil International University
Batch : 63
Department of Computer Science & Engineering

---

## 📬 Feedback

If you find issues or have suggestions for academic improvement, feel free to open an issue or submit a pull request.

---

⭐ If this project helped you understand compiler concepts, consider giving it a star!
