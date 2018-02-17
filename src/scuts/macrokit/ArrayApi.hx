package scuts.macrokit;

using scuts.macrokit.ArrayApi;

@:publicFields class ArrayApi {

	static function flatten <T>(a:Array<Array<T>>):Array<T> {
		return [for (b in a) for (c in b) c];
	}

	static function flatMap <A,B>(a:Array<A>, f:A->Array<B>):Array<B> {
		return a.map(f).flatten();
	}
}