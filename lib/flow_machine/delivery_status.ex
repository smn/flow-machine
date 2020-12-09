defmodule FlowMachine.DeliveryStatus do
  @status_queued "QUEUED"
  def status_queued, do: @status_queued
  @status_ringing "RINGING"
  def status_ringing, do: @status_ringing
  @status_in_progress "IN_PROGRESS"
  def status_in_progress, do: @status_in_progress
  @status_waiting_to_retry "WAITING_TO_RETRY"
  def status_waiting_to_retry, do: @status_waiting_to_retry
  @status_failed_no_answer "FAILED_NO_ANSWER"
  def status_failed_no_answer, do: @status_failed_no_answer
  @status_finished_complete "FINISHED_COMPLETE"
  def status_finished_complete, do: @status_finished_complete
  @status_finished_incomplete "FINISHED_INCOMPLETE"
  def status_finished_incomplete, do: @status_finished_incomplete
  @status_failed_network "FAILED_NETWORK"
  def status_failed_network, do: @status_failed_network
  @status_failed_cancelled "FAILED_CANCELLED"
  def status_failed_cancelled, do: @status_failed_cancelled
  @status_sent "SENT"
  def status_sent, do: @status_sent
  @status_finished_voicemail "FINISHED_VOICEMAIL"
  def status_finished_voicemail, do: @status_finished_voicemail
  @status_failed_voicemail "FAILED_VOICEMAIL"
  def status_failed_voicemail, do: @status_failed_voicemail
  @status_failed_error "FAILED_ERROR"
  def status_failed_error, do: @status_failed_error
end
