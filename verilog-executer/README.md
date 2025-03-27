# Verilog Simulation with Docker and GTKWave

This project demonstrates how to simulate Verilog code using the `hdlc/sim` Docker image and generate a `.vcd` file for waveform visualization with GTKWave.

---

## **Project Structure**

```
verilog_simulation/
├── src/                         # Place your Verilog code here
│   ├── your_design.v            # Main Verilog design file
│   └── testbench.v              # Verilog testbench file
├── output/                      # Simulation output files will be saved here
│   └── simulation_output.vcd    # Generated .vcd file after simulation
└── scripts/
    └── run_simulation.sh         # Script to run the simulation
```

---

## **Setup Instructions**

### **1. Add Your Verilog Files**
- Place your Verilog design file (`your_design.v`) and testbench file (`testbench.v`) in the `src/` directory.
- Ensure your testbench includes commands to dump the waveform data to a `.vcd` file, e.g.:
  ```verilog
  initial begin
      $dumpfile("/output/simulation_output.vcd");
      $dumpvars(0, testbench);
  end
  ```

### **2. Run the Simulation**
Execute the following commands to run the simulation inside the Docker container:

```bash
# Navigate to the project directory
cd path/to/verilog_simulation

# Make the script executable (if not already done)
chmod +x scripts/run_simulation.sh

# Run the simulation
./scripts/run_simulation.sh
```

---

## **Simulation Output**
- The output `.vcd` file will be saved in the `output/` directory:
  ```
  output/simulation_output.vcd
  ```
- If the simulation fails, check for errors in your Verilog code or the Docker output.

---

## **View the Output in GTKWave**
1. **Install GTKWave (if not installed):**
   - On Ubuntu/Debian: `sudo apt-get install gtkwave`
   - On Fedora: `sudo dnf install gtkwave`
   - On MacOS: `brew install gtkwave`
   - For Windows, download from [GTKWave's official site](http://gtkwave.sourceforge.net/).

2. **Open the `.vcd` file:**
   ```bash
   gtkwave output/simulation_output.vcd
   ```

3. **Analyze the Signals:**
   - Use the signal hierarchy panel to select and insert signals into the waveform viewer.
   - Navigate through the simulation time using GTKWave’s controls.

---

## **Example Verilog Files**

### **Design (`src/your_design.v`)**
```verilog
module and_gate(input a, input b, output y);
    assign y = a & b;
endmodule
```

### **Testbench (`src/testbench.v`)**
```verilog
`timescale 1ns/1ps

module testbench;
    reg a, b;
    wire y;

    // Instantiate the design under test (DUT)
    and_gate dut(.a(a), .b(b), .y(y));

    // Dump simulation output to VCD file
    initial begin
        $dumpfile("/output/simulation_output.vcd");
        $dumpvars(0, testbench);

        // Apply test cases
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        // End simulation
        $finish;
    end
endmodule
```

---

## **Troubleshooting**
- **No VCD output:** Ensure the `$dumpfile()` and `$dumpvars()` calls are correctly set in your testbench.
- **Docker permission errors:** Run Docker with `sudo` or ensure your user has permission to run Docker commands.
- **File paths:** Ensure the Verilog files are located in the `src/` directory and the script has access to them.

---

## **References**
- [Docker Hub: hdlc/sim](https://hub.docker.com/r/hdlc/sim)
- [GTKWave Documentation](http://gtkwave.sourceforge.net/)
