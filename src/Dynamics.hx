import thx.culture.Culture;
import thx.error.Error;

/**
 * ...
 * @author Franco Ponticelli
 */

class Dynamics
{
	public static function format(v : Dynamic, ?param : String, ?params : Array<String>, ?nullstring : String, ?culture : Culture)
	{
		return formatf(param, params, nullstring, culture)(v);
	}
	
	public static function formatf(?param : String, ?params : Array<String>, nullstring = 'null', ?culture : Culture)
	{
		return function(v : Dynamic) : String
		{
			switch(Type.typeof(v)) {
				case TNull:
					return nullstring;
				case TInt:
					return Ints.format(v, param, params, culture);
				case TFloat:
					return Floats.format(v, param, params, culture);
				case TBool:
					return Bools.format(v, param, params, culture);
				case TClass(c):
					if(c == String) {
						return Strings.formatOne(v, param, params, culture);
					} else if (c == Array) {
						return Arrays.format(v, param, params, culture);
					} else if(c == Date) {
						return Dates.format(v, param, params, culture);
					} else {
						return Std.string(v);
					}
				default:
					return throw new Error("Unsupported type format: {0}", Type.typeof(v));
			}
		}
	}
	
	public static function interpolate(v : Float, a : Dynamic, b : Dynamic, ?interpolator : Float -> Float)
	{
		return interpolatef(a, b, interpolator)(v);
	}
	
	public static function interpolatef(a : Dynamic, b : Dynamic, ?interpolator : Float -> Float) : Float -> Dynamic
	{
		var ta = Type.typeof(a);
		if (!Type.enumEq(ta, Type.typeof(b)))
			throw new Error("arguments a {0} and b {0} differ in types", [ta, Type.typeof(b)]);
		switch(ta)
		{
			case TNull: return function(_) return null;
			case TInt: return Ints.interpolatef(a, b, interpolator);
			case TFloat: return Floats.interpolatef(a, b, interpolator);
			case TBool: return Bools.interpolatef(a, b, interpolator);
			case TObject: return Dynamics.interpolatef(a, b, interpolator);
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "String": return Strings.interpolatef(a, b, interpolator);
					case "Date": return Dates.interpolatef(a, b, interpolator);
					default: throw new Error("cannot interpolate on instances of {0}", name);
				}
			default: throw new Error("cannot interpolate on functions/enums/unknown");
		}
	}
}