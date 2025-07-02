---
title: "Laser Light Show: Capstone Project"
date: 2023-05-25T21:08:38-04:00
draft: false
featuredImage: "/assets/EECapstone/Photos/figures/cover.png"
authors: ["Dominic"]
---
> **Contributors**: Dominic Benintendi (Software Architecture, Game Engine), Ian Gant (Analog Design, Galvo Control), Aditya Sahi (Firmware, Communication Protocols), Drew Edmonds (Chassis Design, Power Systems)  
> **GitHub Repository**: [DominicBen/LASER-LIGHT-SHOW](https://github.com/DominicBen/LASER-LIGHT-SHOW)

# Introduction
In my final year at Ohio University, I worked on a senior design project that required a full-stack approach to hardware and software integration. Together with my teammates—Ian Gant, Aditya Sahi, and Drew Edmonds—we developed a laser-based game console capable of projecting vector graphics, animations, and multiple playable games using precision-controlled laser beams.

The system, which we named the Laser Light Show, combined embedded systems design, analog signal processing, optics, 3D modeling, software engineering, and real-time control. We set out to design something interactive and technically novel, and we succeeded by staying grounded in first principles and rigorous testing.
[GitHub Repository](https://github.com/DominicBen/LASER-LIGHT-SHOW)

The core idea was to steer a focused laser beam using galvo-mounted mirrors to draw images in mid-air, fast enough to leverage persistence of vision. These vector drawings would be interactive—controlled via handheld input devices—and capable of supporting full game logic.

What started as a technical curiosity evolved into a fully functional embedded console. We supported:

* Pong – a two-player implementation with paddle physics and scorekeeping
* Breakout – single-player block-breaking game
* Flappy Bird – side-scrolling obstacle navigation
* Text and Shape Demos – static and dynamic ILDA-based animations
* RBG Colors - Three colored beams where combined using a prism. Each color channel could be controlled by varying the voltage into the corresponding colored lasers

{{< figure src="/assets/EECapstone/Photos/figures/3lazserv2.jpg" alt="RBG Laser Design" width="600" >}}
# Methods
## 🧩 Software System Architecture
{{< figure src="/assets/EECapstone/Photos/figures/software_overview.drawio.png" alt="Concept Art" width="600" >}}
From the start, we focused on modularity, real-time performance, and low-latency control. We outgrew the Arduino IDE quickly and moved the project into PlatformIO. This allowed me to build a maintainable C++ architecture that supported the growing list of subsystems.

Key Modules:

* Pointer: Handles low-level DAC control and galvo targeting
* Graphic: Abstract class for all drawable objects (e.g., shapes, characters, ILDA)
* Demo: Encapsulates all renderable sequences—games, animations, text
* PhysicsWorld: Custom 2D physics engine for collisions, forces, motion
* GameObject: Wraps graphics with velocity, acceleration, and collision data



{{< video src="/assets/EECapstone/Photos/Snapchat-1287068184-v1.mp4" width="300" >}}


Every game used these shared components. For example, Pong and Breakout both relied on PhysicsWorld for real-time object dynamics. Flappy Bird used axis-aligned bounding box collisions and continuous motion physics. The flexibility of this engine enabled us to add new content rapidly in the final weeks.


## 🛠️ Hardware Design and Mechanical Engineering
{{< figure src="/assets/EECapstone/Photos/figures/hardware_simple.png" alt="Concept Art" width="600" >}}
Ian Gant led the hardware architecture and physical design of the console, with my assistance on several aspects of the system integration and prototyping
Our work included:

* Designing and assembling the motherboard, integrating DACs (MCP4922), op-amps (LM324), and power regulation circuits
* Implementing analog signal processing to convert 0–5V DAC outputs into ±5V differential signals for galvo drivers
* Designing and fabricating a rigid, thermally stable laser mount using 3D-printed components reinforced with aluminum plates
{{< figure src="/assets/EECapstone/Photos/figures/harness.png" alt="Hardness for lasers" width="600" >}}
* Engineering a custom 3D-printed enclosure that included cooling airflow, heatsinks, component cutouts, and a laser-safe optical window

The reliability of the final hardware platform was the direct result of Ian’s iterative prototyping and mechanical foresight. His diagrams, schematics, and part layouts were essential in maintaining signal integrity and thermal performance.

{{< figure src="/assets/EECapstone/Photos/figures/hardware.png" alt="Concept Art" width="600" >}}

Check out his work here, He is an extremely smart guy and deserves credit: https://github.com/Igant01

## 🕹️ Input, Output, and Control

{{< figure src="/assets/EECapstone/Photos/figures/playerinput_controller.drawio.png" alt="Concept Art" width="600" >}}
* Controller Interface
    * Originally designed for Bluetooth, but switched to serial for stability
    * Custom-built controllers featured buttons and joysticks
    * Each controller sent a fixed-length bitstring over UART, parsed asynchronously
{{< figure src="/assets/EECapstone/Photos/figures/controller.png" alt="Controller PCB" width="600" >}}
* LCD Interface
    * Touchscreen menuing system with real-time screen transitions
    * Callback-driven architecture for interactive buttons and sliders
    * Displayed BMP images and supported dynamic resolution scaling

| {{< figure src="/assets/EECapstone/Photos/figures/tetris.bmp" alt="Concept Art" width="600" >}} | {{< figure src="/assets/EECapstone/Photos/figures/pong.bmp" alt="Concept Art" width="600" >}} | {{< figure src="/assets/EECapstone/Photos/figures/flappy_bird.bmp" alt="Concept Art" width="600" >}}
|:--:|:--:|:--:|
* Audio
    * Played WAV files from SD card via I2S audio codec
    * Triggered by in-game events (paddle bounce, score, win/loss)


## 📚 Development History

* October 2022: Project idea proposed by faculty advisor. Initial discussions focused on static vector graphics.
* November 2022: Selected Teensy 4.1 microcontroller and began research on galvanometer mirror control and laser drivers.
{{< figure src="/assets/EECapstone/Photos/20230202_183256.jpg" alt="First Generation of DACS responsible for converting digital signals to differential signals for the galvanometers" width="600" >}}
* December 2022: Built a working prototype that could draw basic shapes. Established software architecture using PlatformIO and began writing modular C++ libraries. Characters where printed from a custom-vector font built from scratch

{{< figure src="/assets/EECapstone/Photos/20230202_183312.jpg" alt="first working grid" width="600" >}}
{{< figure src="/assets/EECapstone/Photos/20230220_145414.jpg" alt="first working grid" width="600" >}}
{{< figure src="/assets/EECapstone/Photos/figures/grid.png" alt="first working grid" width="600" >}}
| {{< figure src="/assets/EECapstone/Photos/figures/digit.png" alt="Concept Art" width="600" >}} | {{< figure src="/assets/EECapstone/Photos/figures/circle.png" alt="Concept Art" width="600" >}} |
|:--:|:--:|
| {{< figure src="/assets/EECapstone/Photos/Snapchat-2086372406.jpg" alt="Pi" width="300" >}} | {{< figure src="/assets/EECapstone/Photos/Snapchat-1080949887.jpg" alt="Cheezeits" width="300" >}} |
| {{< figure src="/assets/EECapstone/Photos/Snapchat-925884038.jpg" alt="Lil Debbie" width="300" >}} | {{< figure src="/assets/EECapstone/Photos/Snapchat-1080949887.jpg" alt="Concept Art" width="300" >}} |




* January 2023: Implemented DAC communication and op-amp signal conditioning. Verified analog output range and started drawing dynamic shapes.

{{< video src="/assets/EECapstone/Photos/Snapchat-59318257-v1.mp4" width="300" >}}
* February 2023: Transitioned from Bluetooth to wired controllers due to interference. Designed the first version of the controller interface.
* March 2023: Integrated LCD touchscreen and built a modular menu system. Rewrote portions of the drawing logic to support frame-based demos.

{{< video src="/assets/EECapstone/Photos/Snapchat-912151343-v1.mp4" width="300" >}}
* April 2023: Final system integration. Resolved thermal drift, completed ILDA streaming logic, and finalized physical assembly. Added support for multiple games and animations.

{{< video src="/assets/EECapstone/Photos/Snapchat-63615931-v1.mp4" width="300" >}}

{{< figure src="/assets/EECapstone/Photos/20230405_150316.jpg" alt="first working grid" width="600" >}}

## 🧪 Systems Integration

Final integration was one of the most difficult stages. Several issues had to be addressed:

* Laser Misalignment: Caused by thermal expansion in 3D printed parts. Fixed with rigid aluminum reinforcement.
* Signal Timing: Synchronized SPI DAC outputs using LDAC pin for precise galvo movement.
* Case Fitment: Resolved mechanical interference between large capacitors and enclosure walls.
* Memory Constraints: Streamed ILDA frames from SD card to avoid RAM overflows.

These were all debugged incrementally. Testing and verification at the system level—hardware, software, and UI combined—was essential.

# Conclusion

* Modular design enables scaling: A clean software architecture allowed us to extend from simple shapes to complex games.
* Start integration early: Working subsystems can fail unexpectedly when combined.
* Mechanical tolerances matter: Laser optics are sensitive to even small alignment errors.
* Reliable input is non-negotiable: Swapping wireless for wired was the right tradeoff.

{{< video src="/assets/EECapstone/Animations/senior_design_video_final_compressed.mp4" alt="Cad model" width="900" >}}

The Laser Light Show Console was both an engineering challenge and a proving ground. It combined embedded control, real-time graphics, interactive input, and hardware design. The difficulties were numerous, which is why winning first place at the expo was all the sweeter.

I’m proud of how our team executed the project from concept to demo. The result wasn’t just technically sound—it was something people could interact with and enjoy. It taught me how to handle complexity, manage risk, and build systems that work under pressure. Ian, if your reading this, Thanks for being my teammate, your a wicked smart dude! I also want to thank our advisor Dan Allwine for his sage wisdom during the project.

— Dominic Benintendi

{{< figure src="/assets/EECapstone/Photos/Snapchat-1304687775.jpg" alt="Pi" width="300" >}}
{{< video src="/assets/EECapstone/Photos/Snapchat-796663386-v1.mp4" width="300" >}}
{{< video src="/assets/EECapstone/Photos/Snapchat-1600023489-v1.mp4" width="300" >}}
