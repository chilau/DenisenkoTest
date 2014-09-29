package com.torikos.events
{
	import com.torikos.events.interfaces.IAdvancedEventDispatcher;

	/**
	 * Контроллер, ведущий контроль подсписок на события
	 */
	public class AdvancedEventDispatcherController
	{
		private var _types:Vector.<String>;
		private var _listeners:Vector.<Function>;
		
		/**
		 * Конструктор
		 */
		public function AdvancedEventDispatcherController()
		{
			_types = new Vector.<String>();
			_listeners = new Vector.<Function>();
		}
		
		/**
		 * Сброс учтённых слушателей.
		 */		
		public function reset(eventDispatcher:IAdvancedEventDispatcher):void
		{
			_types = new Vector.<String>();
			_listeners = new Vector.<Function>();
		}
		
		/**
		 * Добавить подписку на событие
		 */
		public function addEventListener(eventDispatcher:IAdvancedEventDispatcher, type:String, listener:Function):void
		{
			_types.push(type);
			_listeners.push(listener);
		}
		
		/**
		 * Удалить подписку на событие
		 */
		public function removeEventListener(eventDispatcher:IAdvancedEventDispatcher, type:String, listener:Function):void
		{
			for (var i:int = _types.length - 1; i >= 0; i--)
			{
				var _type:String = _types[i] as String;
				if (_type == null)
					continue;
				
				if (i >= _listeners.length)
					continue;
				
				var _listener:Function = _listeners[i] as Function;
				if (_listener == null)
					continue;
				
				if ((_type == type) && (_listener == listener))
				{
					_types.splice(i, 1);
					_listeners.splice(i, 1);
				}
			}
		}
		
		/**
		 * Получить подписку на событие по индексу
		 */
		public function getEventListener(index:int):EventListener
		{
			if (index < 0 || index >= _types.length)
				return null;
			
			var result:EventListener = new EventListener();
			result.type = _types[index];
			result.listener = _listeners[index];
			
			return result;
		}
		
		/**
		 * Получить общее количество подписок на события
		 */
		public function get listenersCount():int
		{
			return _types.length;
		}
		
		/**
		 * Освобождение ресурсов
		 */
		public function dispose():void
		{
			_types = null;
			_listeners = null;
		}
	}
}