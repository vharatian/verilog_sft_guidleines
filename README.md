# ✅ Guideline for Supervised Fine-Tuning (SFT) of Verilog and SystemVerilog Code

This document outlines the step-by-step process for preparing supervised fine-tuning (SFT) data for training large language models in Verilog and SystemVerilog. Trainers should use this guideline to generate multi-turn conversations that teach the model how to respond to realistic coding requests, just like a real engineer would ask.

The final goal is to train the model to **write, explain, and simulate Verilog code** through a series of well-structured conversations.

---

## 🔁 General Process

Each SFT sample should follow a simple structure:

1. **Write a prompt** asking for a piece of Verilog code.
2. **Write the response** as if it’s coming from a chatbot.
3. **Provide proof** that the code runs and behaves correctly.
4. **One Turn,** all the tasks should be only one turn.

> The key goal is to train the model for **coding**. Every prompt should be realted to code and not just asking for discussion.

---

## Task Type

In this project we have the following 4 tasks type and each of them has their own goal and coresponding requirement.

### Code Generation

- This task is primarly aim to craft prompts that are asking for a piece of code. similar to the previous prompts we were creating for RLHF.
- You should not provide any code in the prompt and it should be a pure request.
- The response should consists of the following parts
    1. Generate Code
    2. Testbench to test
    3. Description

### Testbench Generation

- In this task the prompts should be informat of asking for a testbench generation.
- You should always provide the code you want to generate the testbench for
- If your code is simple and generating a full waveform is viable just provide the code and ask for the full testbench
- On the complicated code snippets you can describe the logic and ask for specific aspects of the logic to generate test for.
- Dont use UVM.
- The response should consist of the following parts:
    1. The code you are generating the test for
    2. The generated test bench
    3. A description of what the testbench tests for.

### Code Correction

- You should provide a code and ask for correction. You should provide a code snippet and mention what is wrong with the code and ask to fix it.
- The response should contain the following parts:
    1. The corrected code.
    2. A testbench to check only the logic of the changed part.
    3. Explanation only about the fix.

### Code summarization

- You should ask the model to summarize and annotate a specific code sinpet.

- The response should contian the following parts:
    1. A fully annotated code with comments, dont shy out of putting so many comments but dont add 5 lines of comments for each line of code.
    2. A full explanation of what the code does from the high level and avoid line by line descrption of the code in the explanation part and utlilize comments for that.


## 🧠 Writing Prompts

### Do:
- Stick to the **use case**, but don’t copy it directly.
- Think of the use case as a **theme** or **topic**, not the actual prompt.
- Create realistic, engineer-style requests that someone would actually ask while working.
- Start small (not trivial) within the use case and **explore it gradually over multiple turns**.
- Always ensure that your prompt **requires Verilog code**.
- Use AI tools to brainstorm **ideas**, but never copy from them.
- Make sure the prompt is **answerable** — don’t ask for something you can’t write.
- Keep in mind the goal is to train the model for coding not for providing design decisions or describing fundations, therefor all the prompts should be asking for a specific pisces of code even though you are targeting some sort of design decision.
- If the task is of any of the code correction, code summarization, or TestBench Generation the prompt **must** contain a verilog code

### Don’t:
- ❌ Don’t go off-topic. Stick to the assigned use case.
- ❌ Don't feel that you need to start with all of the use case in the very first prompt and you can move slowly to explore the use case
- ❌ Don’t copy/paste the use case. It’s just the context.
- ❌ Don’t ask open-ended or general questions like:
  > "Discuss different methods for power optimization."
  You will trap yourself trying to explain every method, which makes it hard to manage the scope.
  Instead, ask:
  > "Given this code, optimize it for power by applying clock gating."
- ❌ Don’t make the prompt too basic like:
  > "Write a shift register."
  This is something from chapter one of a textbook and won’t help the model learn real coding workflows.
- ❌ **Strictly** never copy from an AI. Feel free to utilize the AI to come up with ideas or prompts but always right in your own words.


---

## 🤖 Writing Responses

You should always write a **complete and plausible response** to the prompt.

- The response should follow a **clear markdown format**.
- Response is consists of three parts:
    1. **Code**: In this part you should provided the main code designe.
    2. **Testbench**: You should provide the test bench in this cell.
    3. **Explanation**: You should provide a clear expalantion about the code and how
- The code must be **complete**, working, and **compilable on its own**.
- Double-check that your response fully answers the prompt. Use a checklist after writing the prompt to verify completeness.
- **Never include the checklist inside the prompt.**
- The response should be in markdown format:
  - Code blocks: \`\`\`verilog for syntax highlighting
  - Inline code references: wrap variable names or constants with backticks (\`like_this\`)
  - Math or logic formulas: use LaTeX format, like `$a = b + c$`
  - Refere to the markdown guideline: https://www.markdownguide.org/

---

## 📄 Response Structure

Each response should have the following sections:

### 1. **Code**

- Provide the full Verilog or SystemVerilog code.
- It should be:
  - Complete
  - Self-contained
  - Ready to simulate
- Codes should be wrapped in \`\`\`sv blocks
- If the code spans multiple files, each file should come in a seperate wrapping tag.
- Use comments only **when needed**.
- Avoid:
  - Over-commenting every line if the task is not about annotation
  - Writing outputs to an expresion or etc. like:
    > \`// This will output 5\`

### 2. **Testbench**
- Should test all **important behaviors**, not just a single case(minimum 5 - 10 cases).
  - For small modules: test **all combinations**
  - For large designs: test **key behaviors** only
- Testbench should help **evaluate correctness with confidence**, but not be overly complex.
- Keep test bench in one file always and dont spread it.

### 3. **Description**
- Always write something here — never leave it empty.
- Start by listing any **parameters**, **placeholders**, or **required changes** in the code. You should provide all the informaiton that user needs to adapt before being able to user the code in the very begining.
- Describe:
  - The techniques used and describe what they are about
  - The logic behind your approach and how it is implemented in the code
  - The purpose of each part of the design (at a high level)
- Avoid line-by-line explanation of the code we dont need explanation like:
  > In line 24 we add a with b.
- Use:
  - Bullet points
  - Headers
  - Code references (\`like_this\`)
  - LaTeX for any formula
- When writing this part try to keep in mind what you have asked in the prompt and if applicable decompose the prompt into a checklist and make sure you target all those parts in your description.
- If you're showing input/output behavior never rely on the code and testbench:
  - Explain inputs **in the description** and then evaluate the formuals or providing the output
  - Do not rely on the testbench content

---

## 🔬 Proof of Execution

Each turn must include proof that the code runs correctly.

### Required:
- **Execution project**
  - Utiliz our dockerized project to test and visualize the waveform.
  - Zip the file and place it in drive and share the link
  - The project should run immediately with no changes

- **Screenshots**
  - Show waveform output or simulation log
  - Use multiple screenshots if needed

- **Shared Folder**
  - Place all screenshots and the project files in a shared Google Drive folder
  - Share it with the whole team.

---

## 📐 Code Standards

We use **SystemVerilog** as the standard, but:

- All code must compile with **Icarus Verilog 12** (on EDA Playground)
- Icarus 12 does **not support** some SystemVerilog features like unpacked structures — **avoid them**
- Future training rounds may use other tools for full SystemVerilog support
