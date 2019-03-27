
## lime.text.Font:renderGlyph returns garbled image

```.bash
    lime create project font-test
    cp lime-samples/TextRendering/Assets/amiri-regular.ttf font-test/Assets
    cd font-test
```

Make changes to Main.hx:

```.haxe
import sys.io.File;

import lime.app.Application;
import lime.text.Font;
import lime.utils.Assets;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.graphics.ImageFileFormat;


class Main extends Application {
	
	public function new () {
		super ();
	}

    public override function onKeyDown( keyCode : KeyCode, modifier : KeyModifier ) : Void {

        switch( keyCode ) {

            case KeyCode.ESCAPE:
                window.close();

            case KeyCode.F:

            var font = Assets.getFont( 'assets/amiri-regular.ttf' );
            var point = 'b';
            var glyph = font.getGlyph( point );
            var img = font.renderGlyph( glyph, 24 );
            var bytes = img.encode( ImageFileFormat.PNG );
            // change path to whatever fits is best
            var outputPath = Sys.environment().get( 'HOME' ) + '/tmp/glyph_' + point + '.png';
            File.saveBytes( outputPath, bytes );
            
            default:
        }
        
    }
}
```

```.bash
    lime build neko
    lime run neko
```

Press `F` to get glyph PNG image in `$HOME/tmp` folder.
