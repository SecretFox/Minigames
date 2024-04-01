import com.GameInterface.Input;
import com.fox.Minigames.Minigames;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Controls
{
	static var FallInterval:Number;
	static var LeftInterval:Number;
	static var RightInterval:Number;
	
	static function Register()
	{
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeLeft, "com.fox.Minigames.Controls.MoveLeft", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeLeft, "com.fox.Minigames.Controls.StopMoveLeft", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeRight, "com.fox.Minigames.Controls.MoveRight", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeRight, "com.fox.Minigames.Controls.StopMoveRight", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Backward, "com.fox.Minigames.Controls.MoveDown", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Backward, "com.fox.Minigames.Controls.StopMoveDown", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Forward, "com.fox.Minigames.Controls.Rotate", _global.Enums.Hotkey.eHotkeyDown);
	}
	
	static function Unregister()
	{
		clearInterval(FallInterval);
		clearInterval(LeftInterval);
		clearInterval(RightInterval);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeLeft, "", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeRight, "", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeLeft, "", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_StrafeRight, "", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Backward, "", _global.Enums.Hotkey.eHotkeyDown);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Backward, "", _global.Enums.Hotkey.eHotkeyUp);
		Input.RegisterHotkey( _global.Enums.InputCommand.e_InputCommand_Movement_Forward, "", _global.Enums.Hotkey.eHotkeyDown);
	}
	
	static function Rotate()
	{
		if ( Minigames.CurrentGridris.isActive() )
		{
			Minigames.CurrentGridris.CurrentShape.Rotate();
		}
	}
// Left
	static function MoveLeft()
	{
		clearInterval(LeftInterval);
		LeftInterval = setInterval(MoveLeftRepeat, 100);
		MoveLeftRepeat();
	}
	
	static function StopMoveLeft()
	{
		clearInterval(LeftInterval);
	}
	
	static function MoveLeftRepeat() 
	{
		if ( Minigames.CurrentGridris.isActive() )
		{
			Minigames.CurrentGridris.TryMove(Minigames.CurrentGridris.CurrentShape, -1, 0);
		}
	}
	
	static function MoveRight()
	{
		clearInterval(RightInterval);
		RightInterval = setInterval(MoveRightRepeat, 100);
		MoveRightRepeat();
	}
	
	static function StopMoveRight()
	{
		clearInterval(RightInterval);
	}
	
	static function MoveRightRepeat() 
	{
		if ( Minigames.CurrentGridris.isActive() )
		{
			Minigames.CurrentGridris.TryMove(Minigames.CurrentGridris.CurrentShape, 1, 0);
		}
	}
// Down
	static function MoveDown()
	{
		clearInterval(FallInterval);
		FallInterval = setInterval(MoveDownRepeat, 50);
		MoveDownRepeat();
	}
	
	static function StopMoveDown()
	{
		clearInterval(FallInterval);
	}
	
	static function MoveDownRepeat() 
	{
		if ( Minigames.CurrentGridris.isActive() )
		{
			Minigames.CurrentGridris.TryMove(Minigames.CurrentGridris.CurrentShape, 0, 1, true);
		}
	}
	
}