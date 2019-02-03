package scuts.macrokit;

#if macro

import haxe.macro.Context as C;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.ds.Option;



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

	public static function getBaseType (a:Type):Option<BaseType> {
		return switch a {
			case TMono(mt): if (mt == null) None else getBaseType(mt.get());
			case TInst(_.get() => x, _): Some(x);
			case TEnum(_.get() => x, _): Some(x);
			case TAbstract(_.get() => x, _): Some(x);
			case TType(_.get() => x, _): Some(x);
			case TFun(_, _): None;
			case TAbstract(_.get() => x, _): Some(x);
			case TAnonymous(_): None;
			case TDynamic(_):None;
			case TLazy(lz): getBaseType(lz());
		}
	}
}

#end