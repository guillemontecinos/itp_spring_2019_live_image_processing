# Live Image Processing Blog

*by Guillermo Montecinos, NYU ITP Spring 2019*

This document and the contents stored in this repo corresponds to the class [Live Image Processing](https://itp.nyu.edu/classes/lipp/) taught by Matt Romein, at NYU ITP during the 2019 Spring term.

## Week 1
For the second class we were committed to make different kind video footages in order to have a diversity of moving images to use as resource for video processing. I decided to explore different materials that would bring me diverse textures, colors and depth levels, most of them available indoors as water and plants. In terms of technical stuff I made the footage in an horizontal orientation and converted half of the videos using Adobe Premiere and ffmpeg –using the command `ffmpeg -i input.mp4 -c:v prores -an output.mov`

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_2/assets/water1.gif" align="middle" width="70%">
</p>

For example I felt curious of recording the movement of bubbles in a boiling glass made water kettle so I took a shoot of the floor's kitchen kettle which also has a funny blue light. As well, I attempted to explore light reflection through a glass of water and the shapes light can make over a surface.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_2/assets/water3.gif" align="middle" width="70%">
</p>

On the other hand I explored materials as lumber, synthetic grass and leaves of plants that I found in the floor shelves. Something interesting happened in the last one because they are lightened with a ultraviolet set of LEDs which a particular wave length that made a weird interference when I recorded it.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_2/assets/plants1.gif" align="middle" width="70%">
</p>

## Week 2
I built a basic video mixer using the `jit.xfade` function, which receives a float number between 0. and 1. as an input. In this case the number represents the percentage in which the left image is screen versus the right one. Also, I used `umenu` to easily load the videos into the patch.

After that I attempted to apply a downsampling function to one o the channels as we did in class using `jit.matrix` and it's `dim` parameter, bur weirdly this size processing affected both left and the final mix after `xfade`.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_2/assets/mixer_1.gif" align="middle" width="70%">
</p>

## Week 3
During this week I worked in the design of my basic video mixer in Max/Jitter. To afford that I took a bunch of example filters showed in class and explored the possibilities that they opened.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_3/assets/video_mixer_5.png" align="middle" width="70%">
</p>

I explored 4 main effects: `rgb2hsl`, `chromakey`, `op` and `random size`. `rgb2hsl` was chosen as an option to saturate the color of the video since it *misunderstands* the actual color by changing its framework from RGB to HSL. In this case the controls can change Hue *offset* and *scale* as well as Lightness *offset*.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_3/assets/video_rgb2hsl.png" align="middle" width="40%">
</p>

`chromakey` and `op` were fed in a feedback loop with their own output –maybe just for now because I didn't want to over-complicate this patch. For `op` there is a menu connected to it's 1st inlet that allows the user to select which operation want to be calculated. On the other hand, for `chromakey` there is color palette and selector to set *tolerance* and *fade*, both attributes of the object. Finally, a random size block was set after the filtering block as a post processing block.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_3/assets/video_chromakey.png" align="middle" width="40%">
</p>

This is the case of the `chromakey` function I fed with it's own output –after mixing its ARGB planes– to create a weird neon effect. As can be seen in the next next video my exploration wasn't deep in terms of finding psychedelic or weird filtering but was intense in developing a well organized design that could work as a framework where I can incorporate new effects I will find during the next days.

<p align="center">
  <a href="https://vimeo.com/318798051">
    <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_3/assets/mixer_5.gif" align="middle" width="70%">
  </a>
</p>

## Week 4 - Performance 1
The system developed for first performance was built from the video mixer designed during previous weeks. Main differences are that I added a `jit.rota` bock to scale the image of the channel 1 (left side) and that channel 2 (right side) `jit.chromakey` and `jit.op` had the option of being feed by channel 1 matrix as well as through a feedback loop.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_5/performance_01/documentation/final_patch.png" align="middle" width="70%">
</p>

The performance was designed as a audiovisual experience which goal was to immerse the audience in a sensory experience. For that, pre-recorded footage of southern Chile –shoot by my sister Claudia- and *Google Maps* was live mixed using the patch, at the same time that music was generated via Ableton Live. For this a Live set was developed, this was controlled by a MIDI controller and sent MIDI messages to the Max patch.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_5/performance_01/documentation/live_set.png" align="middle" width="70%">
</p>

Video mixing was live controlled from two sources: most parameters as sliders and toggle buttons were controlled via a *Roli Block* device –which can be seen in the presentation mode of the patch–, whilst channel 2 color parameters of `jit.rgb2hsl` and `jit.chromakey` –as hue, offset, tolerance, among others– were set by the MIDI controller used to trigger live set. The presentation mode of the patch reflects the signal flow divided in channels 1 and 2, which can be independently processed and then mixed.

<p align="center">
  <img src="https://github.com/guillemontecinos/itp_spring_2019_live_image_processing/blob/master/week_5/performance_01/documentation/final_presentation.png" align="middle" width="70%">
</p>

A rehearsal of this performance can be seen below. For better understanding of how the different elements interact, both Live and Max were recorded during the documentation process.
