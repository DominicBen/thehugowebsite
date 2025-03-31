---
title: "Graphics Final Project"
date: 2021-12-10T21:08:38-04:00
draft: false
featuredImage: "/assets/graphics_project/image_page5_1.png"
authors: ["Dominic"]
---
#   
**Dominic Benintedi**  
**12/10/21**

Working on this project taught me a priceless amount of information regarding computer graphics. I feel accomplished in how much was achieved with such a simple little project. To dive a little deeper, we will talk about what my project is, what technologies and strategies were used to implement it, what went right, and what went wrong.

To give a quick recap, our goal this project was to implement a 3D Duck Game. I love first-person shooters, so I knew without a doubt that this was something I wanted to do, but creating a 3D Graphics Engine was no easy feat. So through tireless trial and error, I arrived at a product that beautifully illustrates all technological aspects of this class.

Let’s dive right into how exactly I created a 3D graphics engine, starting first from our foundation. The Minecraft Light Project was a good place to start. I had created a camera that can fly around in 3D space, and simple blocks that can be placed or removed with the mouse. The problem with this code is that it was messy and I wanted to create a product that would not only work, but would be clean enough to be worked on in the future. A good portion of my time went into refactoring the basic building blocks that make up an OpenGL program by putting each major component in its own class so that it might be automated.

First was the VBO, VAO, EBO. These were simple enough, but the switch from using `glDrawArrays()` → `glDrawElements()` was a tough one. Wrapping my brain around why exactly it worked took a good portion of time. To simplify: instead of having all 36 of our cube vertices in an array and shipping it off to `glDrawArrays()`, we find the 24 unique points of a cube, including position, color, normal, and UV mapping (we will get to normals and UV later).  
By simply putting these unique vertices into our VBO, and loading our EBO with the 36 indices of our newly created vertices, we have a much more modular and efficient way to draw cubes.

Next was textures. This was a big challenge for me because I had to know UV texture coordinates inside out. Another problem I had to tackle was getting the actual pictures loaded into the program. Thankfully I found an open source C++ script called `stb_image` that takes a `.png` file and converts it to a buffer string. Getting textures wasn’t all that terrible, but getting them to appear on each face of a cube was difficult.

{{< figure src="/assets/graphics_project/image_page2_1.png" alt="Figure 1" width="600" >}}

As you can see, only two sides of the cubes were actually textured. The problem was: while two vertices might share the same position, they might not share the same UV texture coordinates and normals.  
Learning this, I had to take my original 8 vertices and turn it into 24, accounting for UV and normals. This process took some time and changed how I would be rendering things in the future.

{{< figure src="/assets/graphics_project/image_page3_1.png" alt="Figure 2" width="600" >}}

Nice, looks good. Now each side of the square was textured how I wanted. Now was the tricky part: I needed to implement lighting!

This program utilizes the three main lighting techniques: ambient, diffuse, and specular lighting.  
- **Ambient** is a flat brightness level that affects all surfaces equally.  
- **Diffuse** light more heavily impacts surfaces that are facing it.  
- **Specular** simulates light bouncing off surfaces into the user’s eye.

Ambient is very easy—it’s just a scalar value applied to all fragments. But… diffuse and specular are a little more tricky. This is where our lovely normals come into effect. Normals are simply vectors that point perpendicular to any given surface. As you may have surmised from the previous paragraph, normals are now implemented in our vertex array, so referencing these in our vertex shaders is as simple as pie.

Things are looking good now. With normals implemented, we can now use diffuse lighting to its full extent. Specular lighting takes a little more work… As you may already know as a professor of a graphics design class. Specular lighting not only makes use of normals but also makes use of the current camera position. Thankfully, we have implemented a camera class in our last Minecraft Light assignment, so passing over the camera position info as a `vec3` is very easy.  
Now with specular, diffuse, and ambient light all in effect, things are looking groovy. Now it's time to work on our instancing functions.

To this point, we have been placing objects in a restricted grid and creating these cube meshes in our `main()` function. This is unacceptable and must be changed. We do this by first updating our cube class to support a larger variety of customization options, including:
- precise `vec3` position values  
- `vec3` scalar values  
- `vec3` rotation values  

These three values will allow us to create a cube of any size or orientation. The hard part was somehow automating our cube mesh into a changeable and customizable class.

The mesh class—one of the hardest things I have done—takes all the steps we have worked on so far and combines them into an expandable, automatable, easy-to-use class object. This class alone holds all the vertices and indices needed to render any type of object imaginable, **not just cubes.** This is peak performance out of any 3D renderer.

With this in place, and a new class called `Cubes` which handles these diverse and unique cube objects, I would like to present to you…

{{< figure src="/assets/graphics_project/image_page4_1.png" alt="Figure 3" width="600" >}}

**Obama House.** Outstanding, isn’t it? Absolutely brilliant… and the best part? These cube objects are stored in non-volatile memory. By writing to a file before exiting the program, the individual cube objects can be stored and loaded for a future time.

Thankfully, I did not hard code these cubes in by hand—that would have been awful. In order to allow diverse level editing, I made a system that allows the user to click on a cube and edit its attributes live. These attributes include:
- position  
- scale  
- rotation  
- texture  

This tool allows me to create worlds.

In order to allow more options for player movement, I implemented two modes of transportation:
1. Our standard flying 3D camera view  
2. An FPS-style “boots on the ground” view affected by gravity (Survival mode)  

This “Survival Mode” also sports a simple jump button that can be seen in the presentation.

{{< figure src="/assets/graphics_project/image_page5_1.png" alt="Figure 5" width="600" >}}

Beautiful, isn’t it?

---

## Known Issues

Despite its greatness, the program had a few shortcomings:

- Collisions don’t work with rotated objects  
- Normals of objects don’t take into account an object’s rotation  
- User has no collision detection with walls  
- The cursor still shows up when looking around  

---

## Future Improvements

Besides fixing the existing bugs:

- Allow for model loading  
- Implement a proper 3D skybox  
- Implement a diverse object array class  
- Implement a more accurate collision system  
- Implement the use of specular lighting textures  
- Render a crosshair for easier clicking  

---

An experience to be sure—this project was the most fun I have ever had coding in C++. The knowledge gained has immense real-world applications and allows a new line of thinking. I fail to express how much of a blast this was. My knowledge of linear algebra alone has expanded twofold. Never have I had the thought of continuing a project after it’s been graded… until now.

**Thank you.**

---

## Sources

**stb_image** (Used to load images from a file):  
https://github.com/nothings/stb/blob/master/stb_image.h

**Victor Gordan** (Brilliant OpenGL Tutorials):  
https://www.youtube.com/channel/UC8WizezjQVClpWfdKMwtcmw

---

