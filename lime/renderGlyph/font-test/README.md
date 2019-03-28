
## howto

There should be a folder named `tmp` in your `$HOME`. Or you can change `var outputPath` in the code to whatever works best.

Change

```.haxe
    var point = 'b';
```

line to whatever other letter you want rendered.

```.bash
    lime build neko
    lime run neko
```

Press `F` to get glyph PNG image in `$HOME/tmp` folder.
