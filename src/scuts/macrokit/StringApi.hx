package scuts.macrokit;


@:publicFields class StringApi {
	static inline function compare (a:String, b:String) {
		return a < b ? -1 : a > b ? 1 : 0;
	}
}