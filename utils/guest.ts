import { cookies } from "next/headers"
import { randomUUID } from 'crypto'

export async function getGuestId() {
    const cookieStore = await cookies()
    let guestId = cookieStore.get('guest_id')?.value  
    
    if (!guestId) guestId = randomUUID() //If the guest_id cookie doesn't exist, generate a new UUID and set it as the guest_id cookie

    //refresh the guest_id cookie to extend its expiration time
    cookieStore.set('guest_id', guestId, {
        maxAge: 60 * 60 * 24 * 365,
        httpOnly: true,
    })

    return guestId
}
