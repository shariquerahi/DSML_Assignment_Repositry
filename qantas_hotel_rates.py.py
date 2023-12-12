import requests
import config

headers = config.cookies

url = "https://www.qantas.com/hotels/api/ui/properties/18482/availability"

params = {
    "checkIn": "2023-12-26",
    "checkOut": "2023-12-27",
    "adults": "2",
    "children": "0",
    "infants": "0",
    "payWith": "cash",
}

response = requests.get(url, headers=headers, params=params)

if response.status_code == 200:
    data = response.json()

    # Extracting room rates information
    rates = []

    for room_type in data.get("roomTypes", []):
        for offer in room_type.get("offers", []):
            room_name = room_type.get("name", "")
            rate_name = offer.get("name", "")
            num_guests = room_type.get("maxOccupantCount", 0)
            cancellation_policy = offer.get("cancellationPolicy", {}).get("description", "")
            
            # Extracting the correct price from charges and total fields
            price = offer.get("charges", {}).get("total", {}).get("amount", 0) or offer.get("total", {}).get("amount", 0)
            
            is_top_deal = offer.get("promotion", {}).get("name") == "Top Deal"
            currency = offer.get("charges", {}).get("total", {}).get("currency", "") or offer.get("total", {}).get("currency", "")

            # Creating a JSON object for each room
            room_info = {
                "Room_name": room_name,
                "Rate_name": rate_name,
                "Number_of_Guests": num_guests,
                "Cancellation_Policy": cancellation_policy,
                "Price": price,
                "Is_Top_Deal": is_top_deal,
                "Currency": currency,
            }

            rates.append(room_info)

    # Displaying or processing the rates list
    print(rates)

else:
    print(f"Failed to retrieve data. Status Code: {response.status_code}")
