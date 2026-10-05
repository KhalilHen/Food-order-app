enum OrderStatusEnum {
pending,
accepted,
cancelled, 
ready,
unknown;





static OrderStatusEnum fromString(String v) => switch(v) {
  "pending" => pending,
  "accepted" => accepted,
  "cancelled" => cancelled,
  "ready" => ready,
  _ =>  unknown,
};

}