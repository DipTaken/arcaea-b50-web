// Modal component used for the backdrop and dialog box when clicking cards and the add score button
export default function Modal({ ref, children }: { ref: React.RefObject<HTMLDialogElement | null>; children: React.ReactNode }) {
    return (
        <dialog ref={ref}
            className="m-auto backdrop:bg-black/50 backdrop:backdrop-blur-sm bg-transparent"
            // clicking on the backdrop closes the modal
            onClick={(e) => {
                if (e.target === e.currentTarget) e.currentTarget.close()
            }}
        >
            {children}
        </dialog>
    )
}