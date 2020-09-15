# frozen_string_literal: true

require "socket"

icmp = Socket.new(
  Socket::PF_INET,
  Socket::SOCK_RAW,
  Socket::IPPROTO_ICMP
)
