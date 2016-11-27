------------------------
-------- CHAIN ---------
------------------------
-- Spell CHAIN
function ChainMSpring(c)
  if FluffalRemovalCheckCard(c)
  or UseMSpring(c) and Duel.GetCurrentPhase()==PHASE_MAIN1
  then
    return true
  else
    return false
  end

  return false
end
-- Trap CHAIN
function ChainFReserve(c)
  if FluffalRemovalCheckCard(c)
  then
    return true
  elseif Duel.GetCurrentPhase() == PHASE_END
  and CardsMatchingFilter(OppST(),MSTEndPhaseFilter) > 0
  and HasID(AIGrave(),24094653,true) -- Polymerization
  then
    return true
  else
    return false
  end
end
function ChainJAvarice(c)
  return
    FluffalRemovalCheckCard(c)
	or Duel.GetCurrentPhase() == PHASE_END
	--or UseJAvarice(c)
end

function FluffalRemovalCheckCard(c)
  return
    RemovalCheckCard(c,CATEGORY_DESTROY)
	or RemovalCheckCard(c,CATEGORY_REMOVE)
	or RemovalCheckCard(c,CATEGORY_TOGRAVE)
	or RemovalCheckCard(c,CATEGORY_TOHAND)
	or RemovalCheckCard(c,CATEGORY_REMOVE)
end

function FluffalChain(cards)  -- FLUFFAL CHAIN
  if HasID(cards,43455065,ChainMSpring) then -- MSpring
    return 1,CurrentIndex
  end
  if HasID(cards,43898403,ChainTwinTwister) then -- TwinTwisters
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,66127916,ChainFReserve) then -- FReserve
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,98954106,ChainJAvarice) then -- JAvarice
    return 1,CurrentIndex
  end
  if HasIDNotNegated(cards,51452091,false) then -- RDecree
    return 1,CurrentIndex
  end
  return nil
end

function FluffalChainOrder(cards) -- FLUFFAL CHAIN ORDER
  --print("FluffalChainOrder")
  local result = {}

  for i=1,#cards do
    local c = cards[i]
    if c.level > 5 then
      result[#result + 1] = i
    end
  end
  for i=1,#cards do
    local c = cards[i]
    if c.id == 39246582 then -- To protect Dog
      result[#result + 1] = i
    end
  end
  for i=1,#cards do
    local c = cards[i]
    if c.id == 13241004 then -- To protect Penguin
      result[#result + 1] = i
    end
  end
  for i=1,#cards do
    local c=cards[i]
    if not (c.level > 5)
	and not (c.id == 39246582) -- Exclude Dog
	and not (c.id == 13241004) -- Exclude Penguin
	then
      result[#result + 1] = i
    end
  end

  return result
end