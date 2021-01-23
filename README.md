# The Cherno's OpenGL Tutorials (for Nim)

I followed The Cherno's [OpenGL tutorial
series](https://www.youtube.com/playlist?list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2)
on YouTube to learn OpenGL for Nim. In his tutorials, he uses C++, but
since Nim's OpenGL code is very similar to the C++ code, it was easy to
translate his code into Nim. I wanted to create this repo to potential
help others who wanted to learn OpenGL for Nim, but were struggling to
translate the available C++ tutorial into Nim code. In The Cherno's
tutorials, he starts with the basics and gradually builds up a code
base. I stored the state of the code at the end of each episode in a
separate folder. I skipped creating separate folders for the first 6
episodes since it wasn't until the 7th episode that something was drawn
to the screen. So the `ep07` folder contains the combined code of
working through episodes 1 through 7. Likewise, any other skipped episodes
are just ones where there wasn't enough of a change in the code to
warrant it having its own folder, so the progress made in that episode
will just be combined into the folder for the next episode.

## The Videos and the Associated Code
| YouTube Video(s) | Source Code |
| --- | --- |
| 1. [Welcome to OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=1) <br>2. [Setting up OpenGL and Creating a Window in C++](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=2) <br>3. [Using Modern OpenGL in C++](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=3) <br>4. [Vertex Buffers and Drawing a Triangle in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=4) <br>5. [Vertex Attributes and Layouts in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=5) <br>6. [How Shaders Work in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=6) <br>7. [Writing a Shader in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=7) | [ep07](/ep07) |
| 8. [How I Deal with Shaders in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=8) | [ep08](/ep08) |
| 9. [Index Buffers in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=9) | [ep09](/ep09) |
| 10. [Dealing with Errors in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=10) | [ep10](/ep10) |
| 11. [Uniforms in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=11) | [ep11](/ep11) |
| 12. [Vertex Arrays in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=12) <br>13. [Abstracting OpenGL into Classes](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=13) | [ep13](/ep13) |
| 14. [Buffer Layout Abstraction in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=14) | [ep14](/ep14) |
| 15. [Shader Abstraction in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=15) | [ep15](/ep15) |
| 16. [Writing a Basic Renderer in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=16) | [ep16](/ep16) |
| 17. [Textures in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=17) | [ep17](/ep17) |
| 18. [Blending in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=18) <br>19. [Maths in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=19) | [ep19](/ep19) |
| 20. [Projection Matrices in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=20) | [ep20](/ep20) |
| 21. [Model View Projection Matrices in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=21) | [ep21](/ep21) |
| 22. [ImGui in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=22) | [ep22](/ep22) |
| 23. [Rendering Multiple Objects in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=23) | [ep23](/ep23) |
| 24. [Setting up a Test Framework for OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=24) | [ep24](/ep24) |
| 25. [Creating Tests in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=25) | [ep25](/ep25) |
| 26. [Creating a Texture Test in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=26) | [ep26](/ep26) |
| 27. [How to make your UNIFORMS FASTER in OpenGL](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=27) <br>28. [Batch Rendering - An Introduction](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=28) <br>29. [Batch Rendering - Colors](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=29) <br>30. [Batch Rendering - Textures](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=30) <br>31. [Batch Rendering - Dynamic Geometry](https://www.youtube.com/watch?v=71BLZwRGUJE&list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2&index=31) | no code* |

&ast; Episodes 27 - 31 don't build upon the same code base from previous
episodes, so I didn't write the Nim code for them. But they are still
informative episodes to watch and if you wanted to implement them, you
will know how to from having gone through the first 26 episodes.

## To Run the Code
Each episode directory contains an `app.nim` file that will run the code
for that episode. For example, to run `ep07/app.nim`, run the following
command from the repos root directory:
```
nim r --gc:orc ep07/app.nim
```
I use the ORC garbage collector because I use the ``=destroy`()` destructor syntax.

Episode 22 introduces using ImGui. To get it to work, I put the compiled
cimgui file (`cimgui.dylib`) into my project's root directory. However, I
compiled cimgui on my macOS system, so if you are on a different
system, you might have to compile your own version of cimgui to get
ImGui to work. You can find more info about compiling cimgui
[here](https://github.com/cimgui/cimgui).

## Notes
I didn't do everything exactly the same as The Cherno did, for example,
I didn't do error checking on every OpenGL call, but instead just
created a `checkErrors()` proc that I could call at different locations
to probe for errors when needed. Also, I coded things a little
differently than he did is some places, but for the most part it should
be clear where my code differs from what is presented in the videos.

Hopefully this code will make it easier for you to learn OpenGL for Nim.

If you have any questions or suggestions, please [open an issue](/issues).

## The Cherno's Patreon
If you would like to support The Cherno for his helpful educational content,
you can do so through his [Patreon page](https://www.patreon.com/thecherno).