-----------
-- MTQOL --
-----------

minetest.register_chatcommand(
  "QOL_ping",
  {
    func = function (name, params)
      minetest.chat_send_player(name, "Pong!")
      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_whatsthis",
  {
    func = function (name, params)
      local player = minetest.get_player_by_name(name)
      local item = player:get_wielded_item()

      local info = item:get_short_description() or "[Description not found.]"

      local message = \
        "=== Item: ===\n" .. \
        "Name:  " .. item:get_name() .. "\n" .. \
        "Count: " .. item:get_count() .. "\n" .. \
        "Info:  " .. info .. "\n" .. \
        "=== End ==="

      minetest.chat_send_player(name, message)

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_refill",
  {
    privs = {creative = true},
    func = function (name, params)
      local player = minetest.get_player_by_name(name)
      local item = player:get_wielded_item()

      if item:is_empty() then
        minetest.chat_send_player(name, "Can't refill because you aren't holding anything!")
        return true
      end

      item:set_count(item:get_stack_max())
      item:set_wear(0)

      return true
    end
  }
)

minetest.register_chatcommand(
  "QOL_nothungry",
  {
    privs = {creative = true},
    func = function (name, params)
      if hunger_ng ~= nil then
        hunger_ng.alter_hunger(name, 65536, "QOL_nothungry")
        minetest.chat_send_player(name, "You are not hungry.")
      else
        minetest.chat_send_player(name, "Command failed: Can't find hunger_ng.")
      end

      return true
    end
  }
)
