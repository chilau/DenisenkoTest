package com.torikos.controller
{
	import com.torikos.controller.events.DraggableGUIComponentEvent;
	import com.torikos.view.AdvancedSprite;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * Контроллер, описывающий графический примитив
	 */
	public class PrimitiveGUIComponent extends DraggableGUIComponent
	{
		/**
		 * Была ли нажата клавиша Shift при начале перетаскивания
		 */
		protected var _shift:Boolean;
		
		/**
		 * Конструктор
		 */
		public function PrimitiveGUIComponent(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Обработчик события нажатия кнопки мыши
		 */
		protected override function onMouseDown(event:MouseEvent):void
		{
			_shift = event.shiftKey;
			
			_view.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_view.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var sprite:AdvancedSprite = event.target as AdvancedSprite;
			
			_shiftX = event.stageX - _model.x;
			_shiftY = event.stageY - _model.y;
			
			var clickEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.CLICK);
			clickEvent.shiftPressed = _shift;
			clickEvent.canMoveParent = true;
			dispatchEvent(clickEvent);
		}
		
		/**
		 * Обработчик события перемещиня мыши
		 */
		protected override function onMouseMove(event:MouseEvent):void
		{
			if (!_moved)
			{
				_moved = true;
			}
			
			var movedEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.MOVED);
			movedEvent.xPos = event.stageX - _shiftX;
			movedEvent.yPos = event.stageY - _shiftY;
			movedEvent.shiftPressed = _shift;
			movedEvent.canMoveParent = true;
			
			if (!_shift)
			{
				_shiftX = event.stageX - _model.x;
				_shiftY = event.stageY - _model.y;
				
				movedEvent.xPos = movedEvent.xPos - _model.x;
				movedEvent.yPos = movedEvent.yPos - _model.y;
			}
			
			dispatchEvent(movedEvent);
			
			if (_shift)
			{
				_model.x = movedEvent.xPos;
				_model.y = movedEvent.yPos;
				
				_canvas.x = _model.x;
				_canvas.y = _model.y;
			}
		}
	}
}