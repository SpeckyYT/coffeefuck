type Options = {
    length:Number
    size:Number
    timeout:Number
    inputs:Array<Number>
    async:Boolean
}
type Output = {
    output:Array<Number>
    memory:Array<Number>
    timeout:Boolean
    time:Number
}
declare function BrainFuck(instructions:String,options:Options):Output|Promise<Output>
export = BrainFuck
