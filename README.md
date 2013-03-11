# ardu-plot: Multi-plot library for Arduino

If you need to plot multiple series, even in different scales, this is the library for you.

![alt text](https://raw.github.com/saientzg/ardu-plot/master/img/Multiseries_Plotv2.png "Screenshot")



## How to Install

* Drop folder `PlotterV2` at your Arduinos Library folder. ie: ~/Documents/Arduino/libraries

* Drop folder `Multiseries_Plotv2` at your Processing project folder


# Usage

## Concepts

* Viewports: Areas to plot.
* Serie: A line to be plotted into a viewport
* Value: The actual value to be plotted
* Color: The color you want your Serie to have


## Inside setup() method

`plot.portInit( _VIEWPORT_ , _LOWER LIMIT VALUE_ , _UPPER LIMIT VALUE_);`

This will define a Viewport and set the LOWER and UPPER value that the SERIES will contains.
This information will be used to calculate the line height proportionally to the available area.


## Inside the loop() method

` plot.plot( _VIEWPORT_, _SERIE INDEX_, _SERIE NAME_, _VALUE_, _COLOR_);`

This will plot a line at a specific VIEWPORT.


See folder `examples` for more ...

