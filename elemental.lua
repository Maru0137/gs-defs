-- 弱天候
weak_weathers = {}
weak_weathers['火'] = '熱波'
weak_weathers['水'] = '雨'
weak_weathers['雷'] = '雷'
weak_weathers['土'] = '砂塵'
weak_weathers['風'] = '風'
weak_weathers['氷'] = '雪'
weak_weathers['光'] = 'オーロラ'
weak_weathers['闇'] = '妖霧'

-- 強天候
strong_weathers = {}
strong_weathers['火'] = '灼熱波'
strong_weathers['水'] = 'スコール'
strong_weathers['雷'] = '雷雨'
strong_weathers['土'] = '砂嵐'
strong_weathers['風'] = '暴風'
strong_weathers['氷'] = '吹雪'
strong_weathers['光'] = '神光'
strong_weathers['闇'] = '闇'

-- 弱点属性
weaken_elements = {}
weaken_elements['火'] = '水'
weaken_elements['水'] = '雷'
weaken_elements['雷'] = '土'
weaken_elements['土'] = '風'
weaken_elements['風'] = '氷'
weaken_elements['氷'] = '火'
weaken_elements['光'] = '闇'
weaken_elements['闇'] = '光'

function is_weather(spell_element)
    return world.weather_element == spell_element
end

function is_weak_weather(spell_element)
    return world.weather == weak_weathers[spell_element]
end

function is_strong_weather(spell_element)
    return world.weather == strong_weathers[spell_element]
end

function is_inferior_weather(spell_element)
    return world.weather == weaken_weathers[spell_element]
end

function is_day(spell_element)
    return world.day_element == spell_element
end

function is_inferior_day(spell_element)
    return world.day_element == weaken_elements[spell_element]
end

function get_elemental_obi(spell_element)
    if not gear.ElementalObi then
        add_to_chat(122, 'Warning: gear.ElementalObi not defined.')
    end

    -- Use elemental obi preferentially if have it
    if gear.ElementalObi and gear.ElementalObi[spell_element] then
        if is_weather(spell_element) or is_day(spell_element) then
            return gear.ElementalObi[spell_element]
        else
            return nil
        end
        -- Use Hachirin Obi if elemental obi is not available
    elseif gear.HachirinObi then
        if is_strong_weather(spell_element) then                                          -- 15% or 25 % 35%
            return gear.HachirinObi
        elseif is_weak_weather(spell_element) and not is_inferior_day(spell_element) then -- 10%
            return gear.HachirinObi
        elseif is_day(spell_element) and not is_inferior_weather(spell_element) then      -- 10%
            return gear.HachirinObi
        end
    else
        add_to_chat(122, 'Warning: Both of gear.ElementalObi[' .. spell_element .. '] and gear.HachirinObi not defined.')
    end

    return nil
end

function elemental_obi_is_better_than_orpheus(spell_element)
    return is_strong_weather(spell_element) or
        (is_weak_weather(spell_element) and is_day(spell_element))
end

function is_elemental_magic_affedted_by_whether(spell, spell_map)
    return spell.action_type == 'Magic' and
        (spell.skill == '精霊魔法') and
        (spell_map ~= 'ElementalEnfeeble' and spell_map ~= 'Helix')
end

function is_elemental_weapon_skill(spell)
    return spell.action_type == 'WeaponSkill' and spell.element
end
