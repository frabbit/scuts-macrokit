package scuts.macrokit;

using scuts.macrokit.ArrayApi;
import scuts.macrokit.OptionApi;

@:publicFields class ArrayApi {

	@:pure static inline function filterSome <X,Y>(a:Array<X>, f:X->Option<Y>):Array<Y> {
		return catOptions(a.map(f));
	}

	static function flatten <T>(a:Array<Array<T>>):Array<T> {
		return [for (b in a) for (c in b) c];
	}

	static inline function append <T>(a:Array<T>, e:T):Array<T> {
		return a.concat([e]);
	}

	static function drop<T>(a:Array<T>, num:Int):Array<T>
	{
		var res = [];
		var i = 0;
		while (i < num && i < a.length) {
			i++;
		}
		while (i < a.length) {
			res.push(a[i]);
			i++;
		}
		return res;
	}

	static function dropBack<T>(a:Array<T>, num:Int):Array<T>
	{
		return take(a, a.length - num);
	}

	static function take<T> (it:Array<T>, numElements:Int):Array<T>
	{
		var res = [];

		for (i in 0...it.length)
		{
			if (i == numElements) break;
			res.push(it[i]);
		}
		return res;
	}

	static function dropTail <T>(a:Array<T>, num:Int):Array<T> {
		return take(a, a.length - num);
	}

	static function dropLast <T>(a:Array<T>):Array<T> {
		return dropTail(a, 1);
	}

	static function flatMap <A,B>(a:Array<A>, f:A->Array<B>):Array<B> {
		return a.map(f).flatten();
	}

	static function any <A,B>(a:Array<A>, f:A->Bool):Bool {
		for (e in a) {
			if (f(e)) return true;
		}
		return false;
	}

	static function count <A,B>(a:Array<A>, f:A->Bool):Int {
		var r = 0;
		for (e in a) {
			if (f(e)) r++;
		}
		return r;
	}

	static function mapWithIndex < A, B > (arr:Array<A>, f:A->Int->B):Array<B>
	{
		var r = [];
		for (i in 0...arr.length)
		{
			r.push(f(arr[i], i));
		}
		return r;
	}

	static function catOptions <X>(a:Array<Option<X>>):Array<X>
	{
		var res = [];

		for (e in a)
		{
		switch (e) {
			case Some(v): res.push(v);
			case None:
		}
		}
		return res;
	}

	static function foldRight<A,B>(arr:Array<A>, acc:B, f:A->B->B):B
	{
		var rev = reversed(arr);
		for (i in 0...rev.length)
		{
		acc = f(rev[i], acc);
		}
		return acc;
	}

	@:pure static inline function foldLeft<A,B>(arr:Array<A>, acc:B, f:B->A->B):B
	{
		for (i in 0...arr.length)
		{
			acc = f(acc, arr[i]);
		}
		return acc;
	}

	@:pure static inline function foldLeftWithIndex<A,B>(arr:Array<A>, acc:B, f:B->A->Int->B):B
	{
		for (i in 0...arr.length)
		{
			acc = f(acc, arr[i], i);
		}
		return acc;
	}

	public static function reversed <A> (a:Array<A>):Array<A>
	{
		var c = a.length;
		var res = [];
		for (e in a) {
			res[--c] = e;
		}
		return res;
	}

	@:pure public static function some <T>(arr:Array<T>, e:T->Bool):Option<T>
	{
		for (i in arr)
		{
			if (e(i)) return Some(i);
		}
		return None;
	}

	@:pure public static function all <T>(arr:Array<T>, e:T->Bool):Bool
	{
		for (i in arr)
		{
			if (!e(i)) return false;
		}
		return true;
	}

	public static function order <T>(arr:Array<T>, f:T->T->Int):Array<T>
	{
		var x = arr.copy();
		x.sort(f);
		return x;
	}

}