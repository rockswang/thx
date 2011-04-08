/**
 * ...
 * @author Franco Ponticelli
 */

package thx.color;

import Floats;
using Floats;
using thx.math.Interpolations;
import thx.math.Interpolations;

class Grey extends Rgb
{
	public var grey(default, null) : Float;

	public function new( value : Float )
	{
		grey = value.normalize();
		var c = grey.linearRound(0, 255);
		super(c, c, c);
	}
	
	public static function toGrey(rgb : Rgb, ?luminance : PerceivedLuminance)
	{
		if (null == luminance)
			luminance = Perceived;
		switch(luminance)
		{
			case Standard:
				return new Grey(rgb.red / 255 * .2126 + rgb.green / 255 * .7152 + rgb.blue / 255 * .0722);
			case Perceived:
				return new Grey(rgb.red / 255 * .299 + rgb.green / 255 * .587 + rgb.blue / 255 * .114);
			case PerceivedAccurate:
				return new Grey(Math.sqrt(
					  0.241 * Math.pow(rgb.red / 255, 2)
					+ 0.691 * Math.pow(rgb.green / 255, 2)
					+ 0.068 * Math.pow(rgb.blue / 255, 2)
				));
		}
	}
	
	public static function equals(a : Grey, b : Grey)
	{
		return a.grey == b.grey;
	}
	
	public static function darker(color : Grey, t : Float, ?interpolator : Float -> Float -> Float -> Float) : Grey
	{
		var v = t * color.grey;
		return new Grey(null == interpolator ? v : interpolator(v, 0, 1));
	}
	
	public static function interpolate(a : Grey, b : Grey, t : Float, ?interpolator : Float -> Float -> Float -> Float)
	{
		if (null == interpolator)
			interpolator = Interpolations.linear;
		return new Grey(interpolator(t, a.grey, b.grey));
	}
}

enum PerceivedLuminance
{
	Standard;
	Perceived;
	PerceivedAccurate;
}