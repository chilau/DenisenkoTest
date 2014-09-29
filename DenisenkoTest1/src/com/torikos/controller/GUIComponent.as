package com.torikos.controller
{
	import com.torikos.controller.events.GUIComponentEvent;
	import com.torikos.events.AdvancedEventDispatcher;
	import com.torikos.model.BaseGUIModel;
	import com.torikos.model.events.BaseGUIModelEvent;
	import com.torikos.view.BaseGUIView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер графического элемента
	 */
	public class GUIComponent extends AdvancedEventDispatcher
	{
		/**
		 * Главная подложка приложения на которой будет отрисовываться вся графика
		 */
		protected var _parentCanvas:Sprite;
		/**
		 * Подложка объекта
		 */
		protected var _canvas:Sprite;
		
		/**
		 * Конечная коорданата X перемещения объекта
		 */
		private var _newX:int;
		/**
		 * Конечная коорданата Y перемещения объекта
		 */
		private var _newY:int;
		/**
		 * Скорость перемещения
		 */
		private const _moveSpeed:Number = 2;
		
		
		/**
		 * Модель контейнера
		 */
		protected var _model:BaseGUIModel;
		/**
		 * Представление контейнера
		 */
		protected var _view:BaseGUIView;
		
		
		/**
		 * Конструктор
		 */
		public function GUIComponent(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		/**
		 * Инициализировать менеджер представления
		 */
		public function init(canvas:Sprite):void
		{
			_canvas = new Sprite();
			
			_parentCanvas = canvas;
			_parentCanvas.addChild(_canvas);
			
			if (_model != null)
			{
				_canvas.x = _model.x;
				_canvas.y = _model.y;
			}
		}
		
		/**
		 * Перерисовка
		 */
		public function reDraw():void
		{
			clear();
			
			if (_view != null)
			{
				_canvas.addChild(_view);
				_view.draw();
			}
			
			if (_model != null)
			{
				_canvas.x = _model.x;
				_canvas.y = _model.y;
			}
			
			_parentCanvas.addChild(_canvas);
		}
		
		/**
		 * Очистить канву
		 */
		protected function clear():void
		{
			if (_canvas == null)
			{
				return;
			}
			
			for (var i:int = _canvas.numChildren - 1; i >= 0; i--)
			{
				var sprite:Sprite = _canvas.getChildAt(i) as Sprite;
				if (sprite == null)
				{
					continue;
				}
				
				_canvas.removeChild(sprite);
			}
			
			if (_canvas.parent != null)
			{
				_canvas.parent.removeChild(_canvas);
			}
		}
		
		/**
		 * Обработчик события измемения значений модели
		 */
		private function onModelChanged(event:BaseGUIModelEvent):void
		{
			reDraw();
			
			var needRedrawEvent:GUIComponentEvent = new GUIComponentEvent(GUIComponentEvent.NEED_REDRAW);
			dispatchEvent(needRedrawEvent);
		}
		
		/**
		 * Переместить объект в заданную точку
		 */
		public function moveTo(newX:int, newY:int):void
		{
			_newX = newX;
			_newY = newY;
			
			view.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Обработчик события отрисовки сцены
		 */
		private function onEnterFrame(event:Event):void
		{
			if (Math.abs(_newX - _model.x) < 1 && Math.abs(_newY - _model.y) < 1)
			{
				_model.x = _newX;
				_model.y = _newY;
				
				view.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				
				var saveEvent:GUIComponentEvent = new GUIComponentEvent(GUIComponentEvent.NEED_SAVE_SETTINGS);
				dispatchEvent(saveEvent);
				
				return;
			}
			
			_model.x += (_newX - _model.x) / _moveSpeed;
			_model.y += (_newY - _model.y) / _moveSpeed;
			
			_canvas.x = _model.x;
			_canvas.y = _model.y;
		}
		
		/**
		 * Модель
		 */
		public function set model(value:BaseGUIModel):void
		{
			if (_model != null)
			{
				_model.removeAllEventListeners();
			}
			
			_model = value;
			if (_model == null)
			{
				return;
			}
			
			if (_view != null)
			{
				view.model = _model;
			}
			
			_model.addEventListener(BaseGUIModelEvent.SIZE_CHANGED, onModelChanged);
			_model.addEventListener(BaseGUIModelEvent.POSITION_CHANGED, onModelChanged);
			_model.addEventListener(BaseGUIModelEvent.Z_POSITION_CHANGED, onModelChanged);
			_model.addEventListener(BaseGUIModelEvent.ACTIVE_CHANGED, onModelChanged);
			
			if (_canvas != null && _model != null)
			{
				_canvas.x = _model.x;
				_canvas.y = _model.y;
			}
		}
		/**
		 * Модель
		 */
		public function get model():BaseGUIModel
		{
			return _model;
		}
		
		/**
		 * Представление
		 */
		public function set view(value:BaseGUIView):void
		{
			if (_view != null)
			{
				_view.removeAllEventListeners();
			}
			
			_view = value;
			
			if (_view == null)
			{
				return;
			}
			
			_view.model = model;
		}
		/**
		 * Представление
		 */
		public function get view():BaseGUIView
		{
			return _view;
		}
	}
}