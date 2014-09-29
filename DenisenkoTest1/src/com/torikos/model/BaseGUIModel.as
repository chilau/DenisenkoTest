package com.torikos.model
{
	import com.torikos.events.AdvancedEventDispatcher;
	import com.torikos.model.events.BaseGUIModelEvent;
	
	import flash.events.IEventDispatcher;

	/**
	 * Базовый класс, представляющий модель графического элемента
	 */
	public class BaseGUIModel extends AdvancedEventDispatcher
	{
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
		 * Является ли объект активным
		 */
		private var _isActive:Boolean;
		
		
		/**
		 * Конструкто
		 */
		public function BaseGUIModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Задать параметры модели
		 */
		public function setParams(x:int, y:int, z:int, width:int, height:int, color:uint):void
		{
			var changed:Boolean = false;
			
			if (_xPosition != x)
			{
				_xPosition = x;
				changed = true;
			}
			
			if (_yPosition != y)
			{
				_yPosition = y;
				changed = true;
			}
			
			if (changed)
			{
				var positionChangedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.POSITION_CHANGED);
				dispatchEvent(positionChangedEvent);
			}
			
			if (_zPosition != z)
			{
				_zPosition = z;
				
				var zPositionChangedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.Z_POSITION_CHANGED);
				dispatchEvent(zPositionChangedEvent);
			}
			
			changed = false;
			if (_width != width)
			{
				_width = width;
				changed = true;
			}
			
			if (_height != height)
			{
				_height = height;
				changed = true;
			}
			
			if (changed)
			{
				var sizeChangedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.SIZE_CHANGED);
				dispatchEvent(sizeChangedEvent);
			}
			
			if (_color != color)
			{
				_color = color;
				
				var event:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.COLOR_CHANGED);
				dispatchEvent(event);
			}
		}
		
		
		/**
		 * Координата по оси X
		 */
		public function set x(value:Number):void
		{
			if (value != _xPosition)
			{
				_xPosition = value;
				
				var positionChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.POSITION_CHANGED);
				dispatchEvent(positionChengedEvent);
			}
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
			if (value != _yPosition)
			{
				_yPosition = value;
				
				var positionChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.POSITION_CHANGED);
				dispatchEvent(positionChengedEvent);
			}
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
			if (value != _zPosition)
			{
				_zPosition = value;
				
				var positionChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.Z_POSITION_CHANGED);
				dispatchEvent(positionChengedEvent);
			}
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
			if (value <= 0)
			{
				return;
			}
			
			if (value != _width)
			{
				_width = value;
				
				var sizeChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.SIZE_CHANGED);
				dispatchEvent(sizeChengedEvent);
			}
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
			if (value <= 0)
			{
				return;
			}
			
			if (value != _height)
			{
				_height = value;
				
				var sizeChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.SIZE_CHANGED);
				dispatchEvent(sizeChengedEvent);
			}
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
			if (value != _color)
			{
				_color = value;
				
				var event:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.COLOR_CHANGED);
				dispatchEvent(event);
			}
		}
		
		/**
		 * Цвет заливки прямоугольника
		 */
		public function get color():uint
		{
			return _color;
		}
		
		/**
		 * Является ли объект активным
		 */
		public function set isActive(value:Boolean):void
		{
			if (_isActive != value)
			{
				_isActive = value;
				
				var event:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.ACTIVE_CHANGED);
				dispatchEvent(event);
			}
		}
		
		/**
		 * Является ли объект активным
		 */
		public function get isActive():Boolean
		{
			return _isActive;
		}
	}
}