extends Node

#signal player_health_changed(hearts)
signal player_has_landed_on_ground(color)
signal player_has_landed_on_enemy()
signal player_score_changed(amount)
signal player_coin_amount_changed(amount)
signal player_touched_spike()
signal player_picked_up_item(type)
signal player_finished_easy()
signal player_finished_medium()
signal apply_debuff(debuff_id)
signal debuff_applied()

signal player_stat_changed()
signal color_changed(new_color)
