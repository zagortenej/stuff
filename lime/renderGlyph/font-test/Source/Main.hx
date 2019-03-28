package;

import sys.io.File;

import lime.graphics.PixelFormat;
import lime.math.RGBA;
import lime.graphics.Image;
import lime.graphics.ImageBuffer;
import lime.utils.UInt8Array;
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
                Sys.println( "w: " + img.width + ", h: " + img.height);
                Sys.println( "bpp: " + img.buffer.bitsPerPixel + ", len: " + img.data.length );
                Sys.println( "format: " + img.buffer.format + ", premul: " + img.premultiplied );
                Sys.println( "stride: " + img.buffer.stride + ", transp: " + img.transparent );

                // workaround
                var data = new UInt8Array(img.width * img.height * 4);
                var newimgbuf = new ImageBuffer( data, img.width, img.height, 32, PixelFormat.RGBA32 );
                var newimg = new Image(newimgbuf);
                newimg.transparent = true;
                newimg.premultiplied = false;


                var chars = " .:ioVM@";
                for(y in 0...img.height) {
                    for(x in 0...img.width) {
                        var pixel = img.data[ y * img.width + x ];
                        Sys.print( chars.charAt( pixel>>5 ) );
                        // workaround
                        var color = RGBA.create( 0, 0, 0, pixel );
                        newimg.setPixel32(x,y, color, PixelFormat.RGBA32);
                    }
                    Sys.println("");
                }

                var pngbytes = newimg.encode( ImageFileFormat.PNG );
                var outputPath = Sys.environment().get( 'HOME' ) + '/tmp/glyph_' + point + '.png';
                File.saveBytes( outputPath, pngbytes );

            default:
        }
    }
}
