export default function Modal({ ref, children }: { ref: React.RefObject<HTMLDialogElement | null>; children: React.ReactNode }) {
    return (
        <dialog ref={ref}
            className="m-auto backdrop:bg-black/50 backdrop:backdrop-blur-sm bg-transparent" 
            onClick={(e) => {
                const rect = e.currentTarget.getBoundingClientRect()
                const clickedOutside =
                    e.clientX < rect.left || e.clientX > rect.right ||
                    e.clientY < rect.top || e.clientY > rect.bottom
                console.log(`rect: top=${rect.top} left=${rect.left} right=${rect.right} bottom=${rect.bottom} | click: x=${e.clientX} y=${e.clientY} | clickedOutside=${clickedOutside}`)
                if (clickedOutside) {
                    ref.current?.close()
                }
            }}
            >
            {children}
        </dialog>
    )
}