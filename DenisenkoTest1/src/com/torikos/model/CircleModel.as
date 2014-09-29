package com.torikos.model
{
	import com.torikos.model.events.BaseGUIModelEvent;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Класс, описывающий модель окружности
	 */
	public class CircleModel extends BaseGUIModel
	{
		/**
		 * Радиус окружности
		 */
		private var _radius:int;
		
		/**
		 * Конструктор
		 */
		public function CircleModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Задать параметры модели
		 */
		public function setCircleParams(x:int, y:int, z:int, radius:int, color:uint):void
		{
			setParams(x, y, z, radius * 2, radius * 2, color);
			
			if (_radius != radius)
			{
				_radius = radius;
				
				var event:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.SIZE_CHANGED);
				dispatchEvent(event);
			}
		}
		
		/**
		 * Радиус окружности
		 */
		public function set radius(value:int):void
		{
			if (value <= 0)
			{
				return;
			}
			
			if (value != _radius)
			{
				_radius = value;
				
				var sizeChengedEvent:BaseGUIModelEvent = new BaseGUIModelEvent(BaseGUIModelEvent.SIZE_CHANGED);
				dispatchEvent(sizeChengedEvent);
			}
		}
		/**
		 * Радиус окружности
		 */
		public function get radius():int
		{
			return _radius;
		}
	}
}