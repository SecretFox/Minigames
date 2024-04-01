import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.signet extends BaseShape
{
	// Signet
	public var m_ItemId:Number = 9269715;
	public var Shape = [
		[
			[ -2, -1], [ -1, -1], [ 0, -1], [ 1, -1]
		],
		[
			[ 0, -2], [ 0, -1], [ 0, 0], [ 0, 1]
		],
		[
			[ 1, 0], [ 0, 0], [ -1, 0], [ -2, 0]
		],
		[
			[ -1, 1], [ -1, 0], [ -1, -1], [ -1, -2]
		]
	]
	public var KickTable = [
		[
			[0, 1],
			[
				[ -2, 0], [1, 0], [ -2, 1], [1, 2] 
			]
		],
		[
			[1, 2],
			[
				[ -1, 0], [2, 0], [ -1, 2], [2, -1]
			]
		],
		[
			[2, 3],
			[
				[2, 0], [ -1, 0], [2, 1], [ -1, -2] 
			]
		],
		[
			[3, 0],
			[
				[1, 0], [ -2, 0], [1, -2], [ -2, 1]
			]
		]
	]
	
	public function signet(root) 
	{
		super(root);
		m_Name = "signet";
	}
	
}