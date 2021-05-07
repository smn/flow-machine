defmodule FlowMachine.SupportedModes do
  @moduledoc false

  @mode_sms "sms"
  def mode_sms, do: @mode_sms
  @mode_ussd "ussd"
  def mode_ussd, do: @mode_ussd
  @mode_ivr "ivr"
  def mode_ivr, do: @mode_ivr
  @mode_rich_messaging "rich_messaging"
  def mode_rich_messaging, do: @mode_rich_messaging
  @mode_offline "offline"
  def mode_offline, do: @mode_offline
end
