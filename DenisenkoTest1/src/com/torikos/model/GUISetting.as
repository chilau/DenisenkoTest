package com.torikos.model
{
	/**
	 * Класс, хранящий в себе все настройки (количество и расположение объектов)
	 */
	public class GUISetting
	{
		/**
		 * Тип объекта
		 */
		protected var _type:int;
		
		/**
		 * Координата по оси X
		 */
		protected var _xPosition:Number;
		
		/**
		 * Координата по оси Y
		 */
		protected var _yPosition:Number;
		
		/**
		 * Координата по оси Z
		 */
		protected var _zPosition:int;
		
		/**
		 * Ширина
		 */
		protected var _width:int;
		
		/**
		 * Высота
		 */
		protected var _height:int;
		
		/**
		 * Цвет заливки прямоугольника
		 */
		private var _color:uint;
		
		/**
		 * Настройки потомков
		 */
		protected var _childs:Vector.<GUISetting>;
		
		/**
		 * Конструктор
		 */
		public function GUISetting()
		{
			_childs = new Vector.<GUISetting>();
		}
		
		/**
		 * Тип объекта
		 */
		public function set type(value:int):void
		{
			_type = value;
		}
		/**
		 * Тип объекта
		 */
		public function get type():int
		{
			return _type;
		}
		
		/**
		 * Координата по оси X
		 */
		public function set x(value:Number):void
		{
			_xPosition = value;
		}
		/**
		 * Координата по оси X
		 */
		public function get x():Number
		{
			return _xPosition;
		}
		
		/**
		 * Координата по оси Y
		 */
		public function set y(value:Number):void
		{
			_yPosition = value;
		}
		/**
		 * Координата по оси Y
		 */
		public function get y():Number
		{
			return _yPosition;
		}
		
		/**
		 * Координата по оси Z
		 */
		public function set z(value:int):void
		{
			_zPosition = value;
		}
		/**
		 * Координата по оси Z
		 */
		public function get z():int
		{
			return _zPosition;
		}
		
		/**
		 * Ширина
		 */
		public function set width(value:int):void
		{
			_width = value;
		}
		/**
		 * Ширина
		 */
		public function get width():int
		{
			return _width;
		}
		
		/**
		 * Высота
		 */
		public function set height(value:int):void
		{
			_height = value;
		}
		/**
		 * Высота
		 */
		public function get height():int
		{
			return _height;
		}
		
		/**
		 * Цвет заливки прямоугольника
		 */
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		/**
		 * Цвет заливки прямоугольника
		 */
		public function get color():uint
		{
			return _color;
		}
		
		/**
		 * Настройки потомков
		 */
		public function set childs(value:Vector.<GUISetting>):void
		{
			_childs = value;
		}
		/**
		 * Настройки потомков
		 */
		public function get childs():Vector.<GUISetting>
		{
			return _childs;
		}
	}
}