// Modal component used for the backdrop and dialog box when clicking cards and the add score button
export default function Modal({ ref, children, onClose }: { ref: React.RefObject<HTMLDialogElement | null>; children: React.ReactNode; onClose?: () => void }) {
    return (
        <dialog ref={ref}
            className="m-auto w-[min(60vw,60rem)] backdrop:bg-black/50 backdrop:backdrop-blur-sm bg-transparent"
            // fires on every close path (Esc, .close(), the backdrop click below)
            onClose={onClose}
            // clicking on the backdrop closes the modal
            onClick={(e) => {
                if (e.target === e.currentTarget) e.currentTarget.close()
            }}
        >
            {children}
        </dialog>
    )
}