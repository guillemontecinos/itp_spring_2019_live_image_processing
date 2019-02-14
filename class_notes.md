# Live Image Processing Blog Class Notes

* [Github Repo](https://github.com/mromein/lipp_itp_2019)
* [Website](https://itp.nyu.edu/classes/lipp/)

## Week 2

* jit.movie
* jit.window (floating) / jit.pwindow (patch)
* random
* metro: whats the difference with qmetro?
* queries
* route: selectes info from an outlet like a "filter"
* trigger object can have "bang" as arguiment
* jit.grab reads webcam
* jit.matrix
  * when downsampling, information can't be recovered, so upsample just makes a bigger image but with the same amount of information
  * data types: char (0-255), float32 (0.-1.), float64, long
  * dim changes the number of pixels that compose the matrix but not the size of the window.
* jit.fpsgui
* jit.cellblock
* pack: packs information but outputs only when left inlet changes
* pak: the same as pack but outputs whenever inlets change

## Week 3
* `xfade` forces the output matrix size to the left matrix size
* `jit.op @op +` makes an add operation to each one of the pixels of a matrix.
  * Also it can do any kind of math operations between matrices
* `jit.rgb2luma` calculates the luminocity of an image
* `trigger something` triggers the command in a message and adds the mesagge *something*
* take a look of jit.mo package for animations without have to connext `~ezdac`
* `suckah` gets the pixel of a point and returns the color
* Cmd+Y to align patches
* `Gen`
* For next week:
  * Keep learning
  * look for refernts
  * think about what to do for the first performance
