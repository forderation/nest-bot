class Session:
    """
    isi session adalah berupa dictionary (tipe key : value)
    contoh _session = {
        1263712t : {
            "sn": "serial_number",
            "product_state": "baik"
        }
    }
    """

    def __init__(self):
        self._session = {}

    def is_user_active(self, user_id) -> bool:
        return True if str(user_id).strip() in self._session.keys() else False

    def remove_user(self, user_id) -> bool:
        if self.is_user_active(str(user_id).strip()):
            del self._session[str(user_id).strip()]
            return True
        return False

    def add_user(self, user_id, sn: str, product_state: str):
        self._session[str(user_id).strip()] = {
            "sn": sn.upper().strip(),
            "product_state": product_state.lower().strip()
        }
        print(self._session)

    def get_session(self, user_id) -> dict:
        return self._session[str(user_id).strip()]
