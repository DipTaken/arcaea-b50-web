// Modal component used for the backdrop and dialog box when clicking cards and the add score button
interface ModalProps {
    ref: React.RefObject<HTMLDialogElement | null>
    children: React.ReactNode
    onClose?: () => void
    width?: string
}

export default function Modal({ ref, children, onClose, width = "w-[min(60vw,60rem)]" }:  ModalProps) {
    return (
        <dialog ref={ref}
            className={`m-auto ${width} backdrop:bg-black/50 backdrop:backdrop-blur-sm bg-transparent`}
            // fires on every close path (Esc, .close(), the backdrop click below).
            onClose={(e) => {
                if (e.target === e.currentTarget) onClose?.()
            }}
            // clicking on the backdrop closes the modal
            onClick={(e) => {
                if (e.target === e.currentTarget) e.currentTarget.close()
            }}
        >
            {children}
        </dialog>
    )
}