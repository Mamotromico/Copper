extends Node

const INVALID = Vector2(-3,-3)
const DISCONNECTED = Vector2(-1,0)
const BUS_A_NEGATIVE = Vector2(-1,-1)
const BUS_A_POSITIVE = Vector2(-1,1)
const BUS_B_NEGATIVE = Vector2(-1,-2)
const BUS_B_POSITIVE = Vector2(-1,2)
const BUS_LENGTH = 63
const BUS_WIDTH = 5
const BUS_A = 1
const BUS_B = 2

const BLACK_B = 0
const BROWN_B = 1
const RED_B = 2
const ORANGE_B = 3
const YELLOW_B = 4
const GREEN_B = 5
const BLUE_B = 6
const VIOLET_B = 7
const GREY_B = 8
const WHITE_B = 9

const BLACK_M = pow(10, 0)
const BROWN_M = pow(10, 1)
const RED_M = pow(10, 2)
const ORANGE_M = pow(10, 3)
const YELLOW_M = pow(10, 4)
const GREEN_M = pow(10, 5)
const BLUE_M = pow(10, 6)
const VIOLET_M = pow(10, 7)
const GREY_M = pow(10, 8)
const WHITE_M = pow(10, 9)
const GOLD_M = pow(10, -1)
const SILVER_M = pow(10, -2)

const BROWN_T = 1/100
const RED_T = 2/100
const GREEN_T = 0.5/100
const BLUE_T = 0.25/100
const VIOLET_T = 0.1/100
const GREY_T = 0.05/100
const GOLD_T = 5/100
const SILVER_T = 10/100

const BROWN_P = 100
const RED_P = 50
const ORANGE_P = 15
const YELLOW_P = 25
const BLUE_P = 10
const VIOLET_P = 5
