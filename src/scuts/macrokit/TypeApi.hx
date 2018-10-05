package scuts.macrokit;

#if macro

import haxe.macro.Context as C;
import haxe.macro.Expr;
import haxe.macro.Type;




class TypeApi {
	public static function sameType (a:Type, b:Type) {

		var a = { expr: TConst(TNull) , pos: C.currentPos(), t: a};
		var b = { expr: TConst(TNull) , pos: C.currentPos(), t: b};

		var a1 = C.storeTypedExpr(a);
		var b1 = C.storeTypedExpr(b);

		var test = macro {
			function sameType <T>(a:{ t:T}, b:{ t:T }):Bool return true;
			sameType({ t : $a1}, { t : $b1});
		}

		return try {
			C.typeof(test);
			true;
		} catch (e:Dynamic) {
			false;
		}




	}
}

#end